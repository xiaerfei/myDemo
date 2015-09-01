//
//  NSPersistentStoreCoordinator+CoreDataPersistent.h
//  CoreData
//
//  Created by xiaerfei on 15/8/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSPersistentStoreCoordinator (CoreDataPersistent)

+ (NSPersistentStoreCoordinator *)coordinatorWithSqliteStoreNamed:(NSString *)storeFileName;

+ (void)setDefaultPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;



@end
