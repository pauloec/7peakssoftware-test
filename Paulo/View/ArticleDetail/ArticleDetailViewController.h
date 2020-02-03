//
//  ArticleDetailViewController.h
//  Paulo
//
//  Created by Paulo Correa on 15/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleDetailViewModel.h"
#import <UIKit/UIKit.h>

@interface ArticleDetailViewController : UIViewController
- (instancetype)initWithViewModel:(ArticleDetailViewModel *)viewModel;
@end
