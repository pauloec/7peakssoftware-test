//
//  SideMenuViewController.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "SideMenuViewModel.h"
#import <UIKit/UIKit.h>

@protocol SideMenuDelegate <NSObject>
@required
- (void)setNewRootViewController:(NSString *)identifier;
@end

@interface SideMenuViewController : UIViewController 
- (instancetype)initWithViewModel:(SideMenuViewModel *)viewModel;
@property (nonatomic, weak) id <SideMenuDelegate> delegate;
@end
