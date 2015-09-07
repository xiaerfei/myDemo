//
//  NSManagedObjectContext+CoreDataSaves.m
//  CoreData
//
//  Created by xiaerfei on 15/8/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSManagedObjectContext+CoreDataSaves.h"
#import "NSManagedObjectContext+CoreDataRecorder.h"

typedef void(^RootContextSave)(void);

@implementation NSManagedObjectContext (CoreDataSaves)

- (void)coreDataSaves
{
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    NSError *error = nil;
    if ([self concurrencyType] == NSPrivateQueueConcurrencyType) {
        if ([context save:&error]) {
            NSManagedObjectContext *rootObjectContext = [NSManagedObjectContext rootObjectContext];
            RootContextSave rootContextSave = ^ {
                NSError *error = nil;
                if (![rootObjectContext save:&error]) {
                    NSLog(@"Save root context failed and error is %@", error);
                }
            };
            if ([rootObjectContext hasChanges]) {
                [rootObjectContext performBlock:rootContextSave];
            }
        }
    } else {
        if ([context save:&error]) {
            NSManagedObjectContext *rootObjectContext = [NSManagedObjectContext rootObjectContext];
            RootContextSave rootContextSave = ^ {
                NSError *error = nil;
                if (![rootObjectContext save:&error]) {
                    NSLog(@"Save root context failed and error is %@", error);
                }
            };
            if ([rootObjectContext hasChanges]) {
                [rootObjectContext performBlockAndWait:rootContextSave];
            }
        }
    }
}



@end
