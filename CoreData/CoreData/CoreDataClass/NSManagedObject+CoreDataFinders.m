//
//  NSManagedObject+CoreDataFinders.m
//  CoreData
//
//  Created by xiaerfei on 15/9/2.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSManagedObject+CoreDataFinders.h"
#import "NSManagedObjectContext+CoreDataRecorder.h"
#import "NSManagedObject+CoreDataEntity.h"

@implementation NSManagedObject (CoreDataFinders)

+ (NSArray *)findAll
{
    return [self findAllInContext:[NSManagedObjectContext contextForCurrentThread]];
}


+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context
{
    return [self executeFetchRequest:[self createFetchRequestInContext:context] inContext:context];
}

+ (id)findWithPredicate:(NSPredicate *)searchTerm
{
    return [self executeFetchRequest:[self requestAllWithPredicate:searchTerm] inContext:[NSManagedObjectContext contextForCurrentThread]];
}

+ (id)findWhere:(NSString *)property isEqualTo:(id)value
{
    return [self executeFetchRequest:[self requestAllWhere:property isEqualTo:value] inContext:[NSManagedObjectContext contextForCurrentThread]];
}

@end
