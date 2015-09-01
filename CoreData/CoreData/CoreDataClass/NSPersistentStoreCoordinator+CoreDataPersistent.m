//
//  NSPersistentStoreCoordinator+CoreDataPersistent.m
//  CoreData
//
//  Created by xiaerfei on 15/8/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSPersistentStoreCoordinator+CoreDataPersistent.h"

static NSPersistentStoreCoordinator *_persistentStoreCoordinator = nil;


@implementation NSPersistentStoreCoordinator (CoreDataPersistent)


+ (NSPersistentStoreCoordinator *)coordinatorWithSqliteStoreNamed:(NSString *)storeFileName
{
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 构建SQLite数据库文件的路径 sqlite
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:storeFileName]];
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        NSLog(@"----------》》》%@",error);
    }
    return psc;
}


+ (void)setDefaultPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    _persistentStoreCoordinator = persistentStoreCoordinator;
}

+ (NSPersistentStoreCoordinator *)defaultPersistentStoreCoordinator
{
    return _persistentStoreCoordinator;
}

@end
