//
//  NSManagedObjectContext+CoreDataRecorder.m
//  CoreData
//
//  Created by xiaerfei on 15/8/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSManagedObjectContext+CoreDataRecorder.h"
#import "NSPersistentStoreCoordinator+CoreDataPersistent.h"


static NSString const * kCoreDataRecordManagedObjectContextKey = @"NSManagedObjectContextForThreadKey";

static NSManagedObjectContext *_rootObjectContext;
static NSManagedObjectContext *_defaultObjectContext;


@implementation NSManagedObjectContext (CoreDataRecorder)

+ (void)setupCoreDataStackWithStoreNamed:(NSString *)storeName
{
    NSPersistentStoreCoordinator *psc = [NSPersistentStoreCoordinator coordinatorWithSqliteStoreNamed:storeName];
    [NSPersistentStoreCoordinator setDefaultPersistentStoreCoordinator:psc];
    [NSManagedObjectContext initializeDefaultContextWithCoordinator:psc];
}

+ (void)initializeDefaultContextWithCoordinator:(NSPersistentStoreCoordinator *)coordinator
{
    if (_defaultObjectContext == nil)
    {
        NSManagedObjectContext *rootContext = [self contextWithStoreCoordinator:coordinator];
        [self setRootObjectContext:rootContext];
        
        NSManagedObjectContext *defaultContext = [self newMainQueueContext];
        [self setDefaultObjectContext:defaultContext];
        
        [defaultContext setParentContext:rootContext];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mocDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
}

#pragma mark - thread

+ (NSManagedObjectContext *)contextForCurrentThread
{
    if ([NSThread isMainThread]) {
        return [self defaultObjectContext];
    } else {
        NSMutableDictionary *threadDict = [[NSThread currentThread] threadDictionary];
        NSManagedObjectContext *threadContext = [threadDict objectForKey:kCoreDataRecordManagedObjectContextKey];
        if (threadContext == nil) {
            threadContext = [self contextWithParent:[self rootObjectContext]];
            [threadDict setObject:threadContext forKey:kCoreDataRecordManagedObjectContextKey];
        }
        return threadContext;
    }
}

+ (void)clearContextForCurrentThread {
    [[[NSThread currentThread] threadDictionary] removeObjectForKey:kCoreDataRecordManagedObjectContextKey];
}

#pragma mark - default Context
+ (void)setRootObjectContext:(NSManagedObjectContext *)rootObjectContext
{
    if (rootObjectContext != nil) {
        _rootObjectContext = rootObjectContext;
    }
}


+ (void)setDefaultObjectContext:(NSManagedObjectContext *)defaultObjectContext
{
    if (defaultObjectContext != nil) {
        _defaultObjectContext = defaultObjectContext;
    }
}

+ (NSManagedObjectContext *)rootObjectContext
{
    return _rootObjectContext;
}

+ (NSManagedObjectContext *)defaultObjectContext
{
    return _defaultObjectContext;
}

#pragma mark - create context
+ (NSManagedObjectContext *)contextWithStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator
{
    NSManagedObjectContext *context = nil;
    if (coordinator != nil)
    {
        context = [self newPrivateQueueContext];
        [context performBlockAndWait:^{
            [context setPersistentStoreCoordinator:coordinator];
        }];
    }
    return context;
}

+ (NSManagedObjectContext *)contextWithParent:(NSManagedObjectContext *)parentContext
{
    NSManagedObjectContext *context = [self newPrivateQueueContext];
    [context setParentContext:parentContext];
    return context;
}


+ (NSManagedObjectContext *)newPrivateQueueContext
{
    NSManagedObjectContext *context = [[self alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    return context;
}

+ (NSManagedObjectContext *)newMainQueueContext
{
    NSManagedObjectContext *context = [[self alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    return context;
}

#pragma mark - contextSave
- (void)mocDidSaveNotification:(NSNotification *)notification
{
    NSManagedObjectContext *savedContext = [notification object];
    if (_defaultObjectContext == savedContext) {
        return;
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_defaultObjectContext mergeChangesFromContextDidSaveNotification:notification];
    });
    
}


@end
