//
//  BaseViewController.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "UIColor+SPColor.h"
#import "BaseViewController.h"
#import "RouterService.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface BaseViewController () <SideMenuDelegate>
@property (nonatomic, strong) SideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIWindow *overlayWindow;
@end

@implementation BaseViewController
#pragma mark - Init
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController sideViewController:(SideMenuViewController *)sideViewController {
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
        _sideMenuViewController = sideViewController;
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [self changeRootViewController:self.rootViewController];
    
    self.overlayWindow = [[UIWindow alloc] init];
    self.overlayWindow.rootViewController = self.sideMenuViewController;
    self.overlayWindow.backgroundColor = [UIColor clearColor];
    self.overlayWindow.windowLevel = UIWindowLevelStatusBar + 1;
    
    self.sideMenuViewController.delegate = self;
    
    RAC(self, title) = RACObserve(self, rootViewController.title);
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIButton *sideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sideMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [sideMenuButton addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    [sideMenuButton setFrame:CGRectMake(0, 0, 24, 24)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sideMenuButton];
    
    [super viewDidLoad];
}

- (void)updateViewConstraints {
    if ([self.overlayWindow superview]) {
        [self.overlayWindow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    [super updateViewConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - Side Menu Delegate
- (void)setNewRootViewController:(NSString *)identifier {
    [self changeRootViewController:[RouterService viewControllerForIdentifier:identifier data:nil]];
}

#pragma mark - Controller Methods
- (void)openSideMenu {
    [self.overlayWindow makeKeyAndVisible];
}

- (void)changeRootViewController:(UIViewController *)viewController {
    if ([self.rootViewController.view superview]) {
        [self.rootViewController willMoveToParentViewController:nil];
        [self.rootViewController.view removeFromSuperview];
        [self.rootViewController removeFromParentViewController];
        self.rootViewController = nil;
    }
    
    self.rootViewController = viewController;
    [self.view addSubview:self.rootViewController.view];
    [self addChildViewController:self.rootViewController];
    [self.rootViewController didMoveToParentViewController:self];
}
@end
