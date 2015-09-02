//
//  NSManagedObject+CoreDataFinders.h
//  CoreData
//
//  Created by xiaerfei on 15/9/2.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (CoreDataFinders)

+ (NSArray *)findAll;
+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;


@end
