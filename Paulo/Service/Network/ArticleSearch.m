//
//  ArticleSearch.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleSearch.h"
#import "ArticleModel.h"
#import "ArticleListModel.h"
#import "DatabaseService.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const SPserviceBaseURL = @"https://www.apphusetreach.no/application/119267";
static NSString * const SParticlesURL = @"/article/get_articles_list";

@interface ArticleSearch ()
@end

@implementation ArticleSearch
- (RACSignal *)articleSearchSignal {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ArticleListModel *listModel = [ArticleListModel new];
    listModel.title = @"Cars";
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id  subscriber) {
        [manager GET:[NSString stringWithFormat:@"%@%@", SPserviceBaseURL, SParticlesURL]
          parameters:nil
            progress:nil
             success:^(NSURLSessionTask *task, id responseObject) {
                 listModel.articles = [[DatabaseService articleListWithData:responseObject] copy];
                 [subscriber sendNext:listModel];
             } failure:^(NSURLSessionTask *operation, NSError *error) {
                 listModel.articles = [[DatabaseService articleListFromDatabase] copy];
                 [subscriber sendNext:listModel];
             }];
        return nil;
    }];
    
    return signal;
}
@end
