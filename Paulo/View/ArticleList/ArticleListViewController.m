//
//  ArticleListViewController.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "TableViewDataSource.h"
#import "ArticleModel.h"
#import "ArticleListTableViewCell.h"
#import "ArticleListViewController.h"
#import "RouterService.h"
#import "NSDate+Utils.h"
#import <Masonry/Masonry.h>
#import <DRPLoadingSpinner/DRPLoadingSpinner.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const SParticleCellIdentifier = @"CellIdentifier";

@interface ArticleListViewController () <UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DRPLoadingSpinner *spinner;
@property (nonatomic, strong) ArticleListViewModel *viewModel;
@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;
@end

@implementation ArticleListViewController
#pragma mark - Init
- (instancetype)initWithViewModel:(ArticleListViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - Bind ViewModel
- (void)bindViewModel {
    @weakify(self)
    [RACObserve(self, viewModel.articles) subscribeNext:^(id  _Nullable value) {
        @strongify(self);
        if (value && [value count] > 0) {
            [self.spinner stopAnimating];
            self.tableViewDataSource.items = value;
            [self.tableView reloadData];
        }
    }];
    RAC(self, title) = RACObserve(self, viewModel.title);
    
    [RACObserve(self, viewModel.loadError) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"It looks like we had some problems fetching our articles..." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Error"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [self.spinner stopAnimating];
                                                              }];
            [alert addAction:okButton];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                alert.modalPresentationStyle = UIModalPresentationPopover;
                alert.popoverPresentationController.sourceView = self.view;
            }
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark - UITableView Datasource
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

    TableViewBlock tableViewBlock = ^(ArticleListTableViewCell *cell, ArticleModel *article) {
        [cell.articleImage setImageWithURL:[NSURL URLWithString:article.image]];
        cell.titleLabel.text = article.title;
        cell.dateLabel.text = [NSDate dateFromTimestamp:article.created];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:article.ingress];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, article.ingress.length)];
        
        cell.ingressLabel.attributedText = attributedString;
        
        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
            [cell activatePortrait];
        } else {
            [cell activateLandscape];
        }
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initCellIdentifier:SParticleCellIdentifier
                                                                 configureCell:tableViewBlock
                                                                         items:[NSArray new]];
    [self.tableView setDataSource:self.tableViewDataSource];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[ArticleListTableViewCell class] forCellReuseIdentifier:SParticleCellIdentifier];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        return UITableViewAutomaticDimension;
    } else {
        return self.tableView.bounds.size.height - self.navigationController.navigationBar.frame.size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[RouterService viewControllerForIdentifier:@"articleDetailViewController"
                                                                                        data:@{@"data": [self.tableViewDataSource itemAtIndexPath:indexPath]}] animated:YES];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [self setupTableView];
    [self bindViewModel];
    
    self.spinner = [[DRPLoadingSpinner alloc] init];
    self.spinner.colorSequence = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor yellowColor], [UIColor whiteColor]];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view setNeedsUpdateConstraints];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.viewModel.searchCommand execute:nil];

    [super viewDidAppear:animated];
}

- (void)updateViewConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.tableView reloadData];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
@end
