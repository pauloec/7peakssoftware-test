//
//  ArticleDetailViewController.m
//  Paulo
//
//  Created by Paulo Correa on 15/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "NSDate+Utils.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ArticleDetailViewController ()
@property (nonatomic, strong) ArticleDetailViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *ingressLabel;
@property (nonatomic, weak) IBOutlet UILabel *subjectLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *detailImage;
@end

@implementation ArticleDetailViewController

- (instancetype)initWithViewModel:(ArticleDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = self.viewModel.detailTitle;
    self.titleLabel.text = self.viewModel.title;
    self.dateLabel.text = [NSDate dateFromTimestamp:self.viewModel.created];
    self.ingressLabel.text = self.viewModel.ingress;
    self.subjectLabel.text = self.viewModel.subject;
    self.contentDescriptionLabel.text = self.viewModel.contentDescription;
    [self.detailImage setImageWithURL:self.viewModel.imageURL];
    
    [super viewDidLoad];
}

@end
