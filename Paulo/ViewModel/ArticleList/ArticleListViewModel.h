//
//  ArticleListViewModel.h
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleSearchProtocol.h"
#import <Foundation/Foundation.h>

@interface ArticleListViewModel : NSObject
- (instancetype)initWithService:(id<ArticleSearchProtocol>)service;
@property (nonatomic, copy) NSArray *articles;
@property (nonatomic, readonly) RACCommand *searchCommand;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, assign, readonly) BOOL loadError;
@end
