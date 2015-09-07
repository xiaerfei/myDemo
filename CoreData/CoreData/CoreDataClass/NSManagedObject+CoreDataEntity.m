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

+ (id)createEntity
{
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:[NSManagedObjectContext contextForCurrentThread]];
    return newEntity;
}

/***************************************************************************
 *                                 查询方法                                 *
 ***************************************************************************/
#pragma mark - 查询方法
+ (id)executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context
{
    __block NSArray *results = nil;
    [context performBlockAndWait:^{
        NSError *error = nil;
        results = [context executeFetchRequest:request error:&error];
        if (results == nil)
        {
            NSLog(@"%@",error);
        }
        
    }];
    return results;
}
#pragma mark 查询方法 FetchRequest
+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[self entityDescriptionInContext:context]];
    
    return request;
}

+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm
{
    return [self requestAllWithPredicate:searchTerm inContext:[NSManagedObjectContext contextForCurrentThread]];
}

+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:searchTerm];
    return request;
}

+ (NSFetchRequest *)requestAllWhere:(NSString *)property isEqualTo:(id)value
{
    return [self requestAllWhere:property isEqualTo:value inContext:[NSManagedObjectContext contextForCurrentThread]];
}

+ (NSFetchRequest *)requestAllWhere:(NSString *)property isEqualTo:(id)value inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", property, value]];
    
    return request;
}

/***************************************************************************
 *                            NSEntityDescription                          *
 ***************************************************************************/
#pragma mark - NSEntityDescription
+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context
{
    NSString *entityName = [self entityName];
    return [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
}
/***************************************************************************
 *                               Delete Entity                             *
 ***************************************************************************/
- (BOOL)deleteEntityInContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    NSManagedObject *inContext = [context existingObjectWithID:[self objectID] error:&error];
    [context deleteObject:inContext];
    if (error) {
        return NO;
    }
    return YES;
}

- (BOOL)deleteEntity
{
    return [self deleteEntityInContext:[self managedObjectContext]];
}



#pragma mark - other metods
/**
 *   @author xiaerfei, 15-09-02 15:09:09
 *
 *   获取当前 entity 的 name
 *
 *   @return
 */
+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}




@end
