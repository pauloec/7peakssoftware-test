//
//  ArticleListViewModel.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleListModel.h"
#import "ArticleListViewModel.h"

@interface ArticleListViewModel ()
@property (nonatomic, strong) id<ArticleSearchProtocol> service;
@property (nonatomic, retain, readwrite) RACCommand *searchCommand;
@property (nonatomic, retain, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) BOOL loadError;
@end

@implementation ArticleListViewModel
- (instancetype)initWithService:(id<ArticleSearchProtocol>)service {
    self = [super init];
    if (self) {
        @weakify(self);

        _searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [self requestSignal];
        }];
        
        _service = service;
        _loadError = NO;
    }
    return self;
}

- (RACSignal *)requestSignal {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    RACSignal *requestSignal = [self.service articleSearchSignal];
    requestSignal = [requestSignal initially:^{
        self.articles = @[];
    }];
    [requestSignal subscribeNext:^(id  _Nullable value) {
        if ([value isKindOfClass:[ArticleListModel class]]) {
            ArticleListModel *model = value;
            self.articles = model.articles;
            self.title = model.title;
            if ([model.articles count] == 0) {
                self.loadError = YES;
            }
        } else {
            self.loadError = YES;
        }
    }];
    return requestSignal;
}
@end
