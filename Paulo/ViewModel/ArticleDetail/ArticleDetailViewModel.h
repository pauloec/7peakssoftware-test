//
//  ArticleDetailViewModel.h
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleDetailModel.h"
#import <Foundation/Foundation.h>

@interface ArticleDetailViewModel : NSObject
- (instancetype)initWithModel:(ArticleDetailModel *)model;
@property (nonatomic, retain, readonly) NSString *detailTitle;
@property (nonatomic, retain, readonly) NSString *title;
@property (nonatomic, retain, readonly) NSString *ingress;
@property (nonatomic, retain, readonly) NSString *dateTime;
@property (nonatomic, retain, readonly) NSString *type;
@property (nonatomic, retain, readonly) NSString *subject;
@property (nonatomic, retain, readonly) NSString *contentDescription;
@property (nonatomic, retain, readonly) NSURL *imageURL;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, readonly) int64_t created;
@property (nonatomic, readonly) int64_t changed;
@property (nonatomic, readonly) int64_t articleId;
@end
