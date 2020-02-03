//
//  ArticleModel.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ArticleContentModel : NSManagedObject
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, copy) NSString *contentDescription;
@end

@interface ArticleModel : NSManagedObject
@property (nonatomic) int64_t created;
@property (nonatomic) int64_t changed;
@property (nonatomic) int64_t articleId;
@property (nullable, nonatomic, retain) NSSet<ArticleContentModel *> *content;
@property (nullable, nonatomic, retain) NSArray *tags;
@property (nullable, nonatomic, copy) NSString *ingress;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *dateTime;
@end
