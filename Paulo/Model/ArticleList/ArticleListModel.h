//
//  ArticleListModel.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface ArticleListModel : NSObject
@property (nonatomic, strong) NSArray<ArticleModel *> *articles;
@property (nonatomic, strong) NSString *title;
@end
