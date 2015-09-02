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




@end
