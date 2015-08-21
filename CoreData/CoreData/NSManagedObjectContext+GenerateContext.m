//
//  NSManagedObjectContext+GenerateContext.m
//  CoreData
//
//  Created by xiaerfei on 15/8/19.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSManagedObjectContext+GenerateContext.h"

@implementation NSManagedObjectContext (GenerateContext)

+ (NSManagedObjectContext *)generatePrivateContextWithParent:(NSManagedObjectContext *)parentContext {
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.parentContext = parentContext;
    return privateContext;
}

+ (NSManagedObjectContext *)generateStraightPrivateContextWithParent:(NSManagedObjectContext *)mainContext {
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] init];
    privateContext.persistentStoreCoordinator = mainContext.persistentStoreCoordinator;
    return privateContext;
}

@end
