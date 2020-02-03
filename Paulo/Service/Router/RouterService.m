//
//  Router.m
//  Paulo
//
//  Created by Paulo Correa on 12/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "RouterService.h"
#import "PlaceholderViewController.h"
#import "SideMenuViewController.h"
#import "SideMenuModel.h"
#import "SideMenuViewModel.h"
#import "ArticleDetailViewController.h"
#import "ArticleDetailViewModel.h"
#import "ArticleDetailModel.h"
#import "ArticleListViewController.h"
#import "ArticleListViewModel.h"
#import "ArticleSearch.h"
#import "ErrorViewController.h"

@implementation RouterService
+ (UIViewController *)viewControllerForIdentifier:(NSString *)identifier data:(NSDictionary *)data {
    if ([identifier isEqualToString:@"articleListViewController"]) {
        ArticleSearch *articleSearch = [ArticleSearch new];
        ArticleListViewModel *articleViewModel = [[ArticleListViewModel alloc] initWithService:articleSearch];
        return [[ArticleListViewController alloc] initWithViewModel:articleViewModel];
    } else if ([identifier isEqualToString:@"articleDetailViewController"]) {
        ArticleDetailModel *model = [[ArticleDetailModel alloc] initWithArticleModel:[data objectForKey:@"data"] title:@"Car Details"];
        ArticleDetailViewModel *detailViewModel = [[ArticleDetailViewModel alloc] initWithModel:model];
        return [[ArticleDetailViewController alloc] initWithViewModel:detailViewModel];
    } else if ([identifier isEqualToString:@"placeholderViewController"]) {
        return [PlaceholderViewController new];
    } else if ([identifier isEqualToString:@"sideViewController"]) {
        SideMenuViewModel *sideMenuViewModel = [[SideMenuViewModel alloc] initWithModel:[SideMenuModel new]];
        return [[SideMenuViewController alloc] initWithViewModel:sideMenuViewModel];
    } else {
        return [ErrorViewController new];
    }
}
@end
