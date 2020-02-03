//
//  ArticleDetailViewModel.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleModel.h"
#import "ArticleDetailViewModel.h"

@interface ArticleDetailViewModel ()
@property (nonatomic, retain, readwrite) NSString *detailTitle;
@property (nonatomic, retain, readwrite) NSString *title;
@property (nonatomic, retain, readwrite) NSString *ingress;
@property (nonatomic, retain, readwrite) NSString *dateTime;
@property (nonatomic, retain, readwrite) NSString *type;
@property (nonatomic, retain, readwrite) NSString *subject;
@property (nonatomic, retain, readwrite) NSString *contentDescription;
@property (nonatomic, retain, readwrite) NSURL *imageURL;
@property (nonatomic, readwrite) int64_t created;
@property (nonatomic, readwrite) int64_t changed;
@property (nonatomic, readwrite) int64_t articleId;
@end

@implementation ArticleDetailViewModel
- (instancetype)initWithModel:(ArticleDetailModel *)model {
    self = [super init];
    if (self) {
        _detailTitle = model.title;
        _title = model.article.title;
        _ingress = model.article.ingress;
        _dateTime = model.article.dateTime;
        NSArray *contents = [model.article.content allObjects];
        ArticleContentModel *contentModel = [contents firstObject];
        _type = contentModel.type;
        _subject = contentModel.subject;
        _contentDescription = contentModel.contentDescription;
        _imageURL = [NSURL URLWithString:model.article.image];
        _created = model.article.created;
        _changed = model.article.changed;
        _articleId = model.article.articleId;
        _tags = model.article.tags;
    }
    return self;
}
@end
