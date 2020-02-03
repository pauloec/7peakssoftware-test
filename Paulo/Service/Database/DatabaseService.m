//
//  DatabaseService.m
//  Paulo
//
//  Created by Paulo Correa on 15/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "DatabaseService.h"
#import "AppDelegate.h"
#import "ArticleSearch.h"
#import "ArticleModel.h"
#import <CoreData/CoreData.h>

@implementation DatabaseService
+ (NSArray *)articleListWithData:(NSDictionary *)data {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = appDelegate.persistentStoreCoordinator;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    [persistentStoreCoordinator executeRequest:delete withContext:context error:&deleteError];
    if (deleteError) {
        NSLog(@"Unable to delete managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }
    
    NSMutableArray *articleList = [NSMutableArray new];
    for (NSDictionary *articleData in [data objectForKey:@"content"]) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
        ArticleModel *article = [[ArticleModel alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        [article setCreated:[[articleData objectForKey:@"created"] longLongValue]];
        [article setChanged:[[articleData objectForKey:@"changed"] longLongValue]];
        [article setArticleId:[[articleData objectForKey:@"id"] longLongValue]];
        [article setTags:[articleData objectForKey:@"tags"]];
        [article setIngress:[articleData objectForKey:@"ingress"]];
        [article setTitle:[articleData objectForKey:@"title"]];
        [article setImage:[articleData objectForKey:@"image"]];
        [article setDateTime:[articleData objectForKey:@"dateTime"]];
        
        NSMutableSet *articleContentSet = [NSMutableSet new];
        for (NSDictionary *contentDict in [articleData objectForKey:@"content"]) {
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ArticleContent" inManagedObjectContext:context];
            ArticleContentModel *articleContent = [[ArticleContentModel alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
            [articleContent setType:[contentDict objectForKey:@"type"]];
            [articleContent setSubject:[contentDict objectForKey:@"subject"]];
            [articleContent setContentDescription:[contentDict objectForKey:@"description"]];
            [articleContentSet addObject:articleContent];
        }
        
        [article setContent:articleContentSet];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        } else {
            [articleList addObject:article];
        }
    }
    return articleList;
}

+ (NSArray *)articleListFromDatabase {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    } 
    
    return result;
}
@end
