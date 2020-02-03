//
//  ArticleListViewController.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleListViewModel.h"
#import <UIKit/UIKit.h>

@interface ArticleListViewController : UIViewController
- (instancetype)initWithViewModel:(ArticleListViewModel *)viewModel;
@end
