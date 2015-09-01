//
//  NSManagedObject+CoreDataEntity.h
//  CoreData
//
//  Created by xiaerfei on 15/8/27.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (CoreDataEntity)


+ (id)createEntityWithName:(NSString *)entityName;

@end
