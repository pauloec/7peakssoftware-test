//
//  BaseViewController.h
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "SideMenuViewController.h"
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController sideViewController:(SideMenuViewController *)sideViewController;
@end
