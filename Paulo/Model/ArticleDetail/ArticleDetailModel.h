//
//  ArticleDetailModel.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface ArticleDetailModel : NSObject
- (instancetype)initWithArticleModel:(ArticleModel *)article title:(NSString *)title;
@property (nonatomic, weak) ArticleModel *article;
@property (nonatomic, retain, readonly) NSString *title;
@end
