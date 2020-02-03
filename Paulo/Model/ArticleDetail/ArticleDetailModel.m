//
//  ArticleDetailModel.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleDetailModel.h"
@interface ArticleDetailModel ()
@property (nonatomic, retain, readwrite) NSString *title;
@end

@implementation ArticleDetailModel
- (instancetype)initWithArticleModel:(ArticleModel *)article title:(NSString *)title{
    self = [super init];
    if (self) {
        _article = article;
        _title = title;
    }
    return self;
}
@end
