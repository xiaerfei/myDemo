//
//  ViewController.m
//  CoreData
//
//  Created by xiaerfei on 15/8/19.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Card.h"
#import "NSManagedObjectContext+GenerateContext.h"

#import "CoreDataRecorder.h"

typedef void(^RootContextSave)(void);
typedef void(^CompletionBlock)(BOOL operationSuccess, id responseObject, NSString *errorMessage);

@interface ViewController ()

@property (nonatomic, strong) NSManagedObjectContext *rootObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",NSStringFromClass([self class]));
////    [self refreshData];
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    for (Person *person in fetchedObjects) {
//        NSLog(@"name = %@ age = %@ no = %@",person.name,person.age,person.card.no);
//    }
    
    
    [NSManagedObjectContext setupCoreDataStackWithStoreNamed:@"CoreData.sqlite"];
//    Person *person = [Person createEntity];
//    person.name = @"hahahha";
//    person.age  = @26;
//    
//    Card *card = [Card createEntity];
//    card.no = @"982323238102938028402893";
//    person.card = card;
//    [[NSManagedObjectContext defaultObjectContext] coreDataSaves];
    
    NSArray *persons = [Person findAll];
    for (Person *person in persons) {
        NSLog(@"name = %@ age = %@ no = %@",person.name,person.age,person.card.no);
        person.name = @"dlfja;ldfjsdfsdfs";
        person.age = @25;
        person.card.no = @"123456789";
    }
    
    [[NSManagedObjectContext defaultObjectContext] coreDataSaves];
    
}




@end
