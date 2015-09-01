//
//  NSManagedObject+CoreDataEntity.m
//  CoreData
//
//  Created by xiaerfei on 15/8/27.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSManagedObject+CoreDataEntity.h"
#import "NSManagedObjectContext+CoreDataRecorder.h"

@implementation NSManagedObject (CoreDataEntity)

+ (id)createEntityWithName:(NSString *)entityName
{
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[NSManagedObjectContext contextForCurrentThread]];
    return newEntity;
}

@end
