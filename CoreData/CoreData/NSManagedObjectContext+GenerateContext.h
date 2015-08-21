//
//  NSManagedObjectContext+GenerateContext.h
//  CoreData
//
//  Created by xiaerfei on 15/8/19.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (GenerateContext)

+ (NSManagedObjectContext *)generatePrivateContextWithParent:(NSManagedObjectContext *)parentContext;
+ (NSManagedObjectContext *)generateStraightPrivateContextWithParent:(NSManagedObjectContext *)mainContext;
@end
