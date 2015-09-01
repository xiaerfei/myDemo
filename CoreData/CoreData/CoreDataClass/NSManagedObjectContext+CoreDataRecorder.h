//
//  NSManagedObjectContext+CoreDataRecorder.h
//  CoreData
//
//  Created by xiaerfei on 15/8/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CoreDataRecorder)

+ (void)setupCoreDataStackWithStoreNamed:(NSString *)storeName;

+ (NSManagedObjectContext *)contextForCurrentThread;

+ (NSManagedObjectContext *)rootObjectContext;

+ (NSManagedObjectContext *)defaultObjectContext;
@end
