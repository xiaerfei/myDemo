//
//  CoreDataManager.m
//  CoreData
//
//  Created by xiaerfei on 15/8/20.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//
/*
 persistentStoreCoordinator<-backgroundContext<-mainContext<-privateContext
 这种设计是第一种的改进设计，也是上述的老外博主推荐的一种设计方式。它总共有三个Context，一是连接persistentStoreCoordinator也是最底层的backgroundContext，二是UI线程的mainContext，三是子线程的privateContext，后两个Context在1中已经介绍过了，这里就不再具体介绍，他们的关系是privateContext.parentContext = mainContext, mainContext.parentContext = backgroundContext。下面说说它的具体工作流程。
 在应用中，如果我们有API操作，首先我们会起一个子线程进行API请求，在得到Response后要进行数据库操作，这是我们要创建一个privateContext进行数据的增删改查，然后call privateContext的save方法进行存储，这里的save操作只是将所有数据变动Push up到它的父Context中也就是mainContext中，然后mainContext继续call save方法，将数据变动Push up到它的父Context中也就是backgroundContext，最后调用backgroundContext的save方法真正将数据变动存储到Disk数据库中，在这个过程中，前两个save操作相对耗时较少，真正耗时的操作是最后backgroundContext的save操作，因为只有它有Disk IO的操作。
 
 */


#import "CoreDataManager.h"
#import "Person.h"
#import "Card.h"
#import "NSManagedObjectContext+GenerateContext.h"


typedef void(^RootContextSave)(void);
typedef void(^CompletionBlock)(BOOL operationSuccess, id responseObject, NSString *errorMessage);

@interface CoreDataManager ()

@property (nonatomic, strong) NSManagedObjectContext *rootObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager



#pragma mark - Demo
- (void)getEmployeesWithMainContext:(NSManagedObjectContext *)mainContext completionBlock:(CompletionBlock)block {
    
    NSManagedObjectContext *workContext = [NSManagedObjectContext generatePrivateContextWithParent:mainContext];
    [workContext performBlock:^{
        [self insertOrUpdateWithContext:workContext];
        
        
        NSError *error = nil;
        if([workContext save:&error]) {
            NSLog(@"开始保存");
            block(YES, nil, nil);
        }
        else {
            NSLog(@"Save employee failed and error is %@", error);
            block(NO, nil, @"Get emploree failed");
        }
    }];
}

- (void)insertOrUpdateWithContext:(NSManagedObjectContext *)workContext
{
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:workContext];
    person.name = @"xiaerfei";
    person.age = [NSNumber numberWithInteger:26];
    
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:workContext];
    card.no = @"1984029392187418237";
    
    person.card = card;
    
}
#pragma mark - private methods
/**
 *   @author xiaerfei, 15-08-19 15:08:59
 *
 *   每次privateContext调用save方法成功之后都要call这个方法
 *
 *   @param needWait
 */
- (void)saveContextWithWait:(BOOL)needWait
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSManagedObjectContext *rootObjectContext    = self.rootObjectContext;
    
    if (nil == managedObjectContext) {
        return;
    }
    if ([managedObjectContext hasChanges]) {
        NSLog(@"Main context need to save");
        [managedObjectContext performBlockAndWait:^{
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Save main context failed and error is %@", error);
            }
        }];
    }
    
    if (nil == rootObjectContext) {
        return;
    }
    
    RootContextSave rootContextSave = ^ {
        NSError *error = nil;
        if (![rootObjectContext save:&error]) {
            NSLog(@"Save root context failed and error is %@", error);
        }
    };
    
    if ([rootObjectContext hasChanges]) {
        NSLog(@"Root context need to save");
        if (needWait) {
            [rootObjectContext performBlockAndWait:rootContextSave];
        }
        else {
            [rootObjectContext performBlock:rootContextSave];
        }
    }
}

-(void)handleResult:(id)operationSuccess {
    if ([operationSuccess boolValue]) {
        NSLog(@"Operation success");
        [self saveContext];
    } else {
        NSLog(@"Operation failed!");
    }
}

-(void)saveContext {
    [self saveContextWithWait:NO];
}

-(void)refreshData {
    [self getEmployeesWithMainContext:self.managedObjectContext completionBlock:^(BOOL operationSuccess, id responseObject, NSString *errorMessage) {
        if ([NSThread isMainThread]) {
            NSLog(@"Handle result is main thread");
            [self handleResult:[NSNumber numberWithBool:operationSuccess]];
        }
        else {
            NSLog(@"Handle result is other thread");
            [self performSelectorOnMainThread:@selector(handleResult:) withObject:[NSNumber numberWithBool:operationSuccess] waitUntilDone:YES];
        }
    }];
}
#pragma mark - getters
/**
 *   @author xiaerfei, 15-08-19 15:08:25
 *
 *   创建  NSPersistentStoreCoordinator
 *
 *   @return
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator == nil) {
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // 构建SQLite数据库文件的路径 sqlite
        NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"CoreData.sqlite"]];
        NSError *error = nil;
        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
        if (store == nil) {
            NSLog(@"----------》》》%@",error);
        }
    }
    return _persistentStoreCoordinator;
}
/**
 *   @author xiaerfei, 15-08-19 15:08:00
 *
 *   backgroundContext
 *
 *   @return
 */
- (NSManagedObjectContext *)rootObjectContext {
    if (nil != _rootObjectContext) {
        return _rootObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _rootObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_rootObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _rootObjectContext;
}
/**
 *   @author xiaerfei, 15-08-19 15:08:51
 *
 *   mainContext
 *
 *   @return
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (nil != _managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.parentContext = self.rootObjectContext;
    return _managedObjectContext;
}

@end
