//
//  SideMenuViewController.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "TableViewDataSource.h"
#import "UIColor+SPColor.h"
#import "SideMenuModel.h"
#import "SideMenuViewController.h"
#import "AppDelegate.h"
#import <Masonry/Masonry.h>

static CGFloat const SPshadowOpacity = 0.5f;
static CGFloat const SPsideMenuWidth = 280.0f;
static CGFloat const SPimageBackgroundHeight = 1.8;
static CGFloat const SPlogoNameFontSize = 17;
static CGFloat const SPlogoNameTopPadding = 8;
static CGFloat const SPlogoImageTopOffset = 10;
static NSString * const SPsideMenuCellIdentifier = @"CellIdentifier";

@interface SideMenuViewController () <UITableViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *logoLabel;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITapGestureRecognizer *closeTap;
@property (nonatomic, strong) NSString *backgroundImage;
@property (nonatomic, strong) NSString *logoImage;
@property (nonatomic, strong) NSString *logoName;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) SideMenuViewModel *viewModel;
@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;
@property (nonatomic, readwrite) BOOL isOpen;
@end

@implementation SideMenuViewController
#pragma mark - Init
- (instancetype)initWithViewModel:(SideMenuViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _isOpen = NO;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [self bindViewModel];
    [self setupTableView];
    
    self.closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
    self.shadowView = [UIView new];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = .0f;
    [self.shadowView addGestureRecognizer:self.closeTap];
    [self.view addSubview:self.shadowView];
    
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor sideMenuBackgroundColor];
    [self.view addSubview:self.backgroundView];
    
    self.headerView = [UIView new];

    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backgroundImage]];
    [self.headerView addSubview:self.backgroundImageView];

    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.logoImage]];
    [self.headerView addSubview:self.logoImageView];

    self.logoLabel = [UILabel new];
    self.logoLabel.text = self.logoName;
    self.logoLabel.textColor = [UIColor whiteColor];
    self.logoLabel.font = [UIFont systemFontOfSize:SPlogoNameFontSize weight:UIFontWeightMedium];
    [self.headerView addSubview:self.logoLabel];
    
    [self.backgroundView addSubview:self.headerView];
    [self.backgroundView addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view setNeedsUpdateConstraints];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showMenu];
}

- (void)updateViewConstraints {
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.top.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.width.mas_equalTo(SPsideMenuWidth + self.view.mas_safeAreaLayoutGuideLeft.layoutAttribute);
        } else {
            make.width.mas_equalTo(SPsideMenuWidth);
        }
        make.left.equalTo(self.view).with.offset(self.isOpen ? 0.0f : -SPsideMenuWidth);
    }];
    
    [self.shadowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView);
        make.height.equalTo(self.headerView.mas_width).dividedBy(SPimageBackgroundHeight);
        
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.backgroundView.mas_safeAreaLayoutGuideLeft);
        } else {
            make.top.and.left.equalTo(self.backgroundView);
        }
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.backgroundView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.centerY.equalTo(self.headerView).with.offset(-SPlogoImageTopOffset);
        make.width.mas_equalTo(self.logoImageView.image.size.width / 1.5);
        make.height.equalTo(self.logoImageView.mas_width).dividedBy(1.5);
    }];
    
    [self.logoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoImageView);
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(SPlogoNameTopPadding);
    }];
    
    [super updateViewConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - Bind ViewModel
- (void)bindViewModel {
    _logoName = self.viewModel.logoName;
    _logoImage = self.viewModel.logoImage;
    _backgroundImage = self.viewModel.backgroundImage;
    _items = self.viewModel.items;
}

#pragma mark - UITableView Datasource
- (void)setupTableView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

    TableViewBlock tableViewBlock = ^(UITableViewCell *cell, SideMenuItemModel *option) {
        cell.imageView.image = [UIImage imageNamed:option.imageDetail];
        cell.textLabel.text = option.title;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initCellIdentifier:SPsideMenuCellIdentifier
                                                                 configureCell:tableViewBlock
                                                                         items:self.items];
    [self.tableView setDataSource:self.tableViewDataSource];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SPsideMenuCellIdentifier];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setNewRootViewController:)]) {
        [self.delegate setNewRootViewController:[(SideMenuItemModel *) [self.tableViewDataSource itemAtIndexPath:indexPath] identifier]];
        [self closeMenu];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Controller Methods
- (void)showMenu {
    _isOpen = YES;
    [UIView animateWithDuration:.3 animations:^{
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
        self.shadowView.alpha = SPshadowOpacity;
    }];
}

- (void)closeMenu {
    _isOpen = NO;
    [UIView animateWithDuration:.3 animations:^{
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
        self.shadowView.alpha = .0f;
    } completion:^(BOOL finished) {
        self.view.window.hidden = YES;
        [self.view removeFromSuperview];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window makeKeyWindow];
    }];
}
@end
