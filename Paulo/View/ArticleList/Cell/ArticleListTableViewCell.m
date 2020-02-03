//
//  ArticleListTableViewCell.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "UIColor+SPColor.h"
#import "ArticleListTableViewCell.h"
#import <Masonry/Masonry.h>
#import <TTOBGradientView/OBGradientView.h>

static CGFloat const SParticleImageFontSize = 24;
static CGFloat const SParticleDateFontSize = 13;
static CGFloat const SParticleIngressFontSize = 14;
static CGFloat const SParticleOverlayTopPadding = 130;
static CGFloat const SParticleTitleLeftPadding = 16;
static CGFloat const SParticleTitleRightPadding = 7;
static CGFloat const SParticleTitleTopPadding = 90;
static CGFloat const SParticleDateTopPadding = 6;
static CGFloat const SParticleIngressTopPadding = 18;
static CGFloat const SParticleIngressBottomPadding = 16;
static CGFloat const SParticleIndicatorRightPadding = 15;
static NSString * const SPsideMenuCellIdentifier = @"CellIdentifier";

@interface ArticleListTableViewCell ()
@property (nonatomic, strong) OBGradientView *shadowOverlay;
@property (nonatomic, assign) BOOL didSetConstraints;
@property (nonatomic, strong) NSArray *portraitLayout;
@property (nonatomic, strong) NSArray *landscapeLayout;
@property (nonatomic, strong) UIImageView *indicator;
@end

@implementation ArticleListTableViewCell
#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.articleImage = [UIImageView new];
        self.articleImage.contentMode = UIViewContentModeScaleAspectFill;
        self.articleImage.clipsToBounds = YES;
        self.articleImage.backgroundColor = [UIColor clearColor];
        self.articleImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.articleImage];
        
        self.shadowOverlay = [OBGradientView new];
        self.shadowOverlay.colors = @[[UIColor clearColor], [UIColor blackColor]];
        self.shadowOverlay.startPoint = CGPointMake(0, 0);
        self.shadowOverlay.endPoint = CGPointMake(0, 0.7);
        self.shadowOverlay.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.shadowOverlay];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:SParticleImageFontSize weight:UIFontWeightMedium];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel sizeToFit];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleLabel];
        
        self.dateLabel = [UILabel new];
        self.dateLabel.font = [UIFont systemFontOfSize:SParticleDateFontSize weight:UIFontWeightRegular];
        self.dateLabel.textColor = [UIColor articleDateTextColor];
        self.dateLabel.numberOfLines = 0;
        [self.dateLabel sizeToFit];
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.dateLabel];
        
        self.ingressLabel = [UILabel new];
        self.ingressLabel.font = [UIFont systemFontOfSize:SParticleIngressFontSize weight:UIFontWeightMedium];
        self.ingressLabel.textColor = [UIColor whiteColor];
        self.ingressLabel.numberOfLines = 0;
        [self.ingressLabel sizeToFit];
        self.ingressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.ingressLabel];
        
        self.indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevronRight"]];
        self.indicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.indicator];
        
        [self setGenericAnchors];
        self.portraitLayout = [self portraitConstraints];
        self.landscapeLayout = [self landscapeConstraints];
    }
    return self;
}

#pragma mark - Cell Method
- (void)setGenericAnchors {
    [NSLayoutConstraint activateConstraints:@[[self.articleImage.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [self.articleImage.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.articleImage.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
                                              [self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:SParticleTitleLeftPadding],
                                              [self.titleLabel.rightAnchor constraintEqualToAnchor:self.indicator.leftAnchor constant:-SParticleTitleRightPadding],
                                              [self.dateLabel.leftAnchor constraintEqualToAnchor:self.titleLabel.leftAnchor],
                                              [self.dateLabel.rightAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor],
                                              [self.ingressLabel.leftAnchor constraintEqualToAnchor:self.titleLabel.leftAnchor],
                                              [self.ingressLabel.rightAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor],
                                              [self.shadowOverlay.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.shadowOverlay.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
                                              [self.shadowOverlay.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor constant:-SParticleOverlayTopPadding],
                                              [self.shadowOverlay.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                              [self.indicator.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-SParticleIndicatorRightPadding],
                                              [self.indicator.bottomAnchor constraintEqualToAnchor:self.ingressLabel.bottomAnchor],
                                              [self.indicator.heightAnchor constraintEqualToConstant:self.indicator.image.size.height],
                                              [self.indicator.widthAnchor constraintEqualToConstant:self.indicator.image.size.width]
                                              ]];
}

- (NSArray *)portraitConstraints {
    return @[[self.articleImage.heightAnchor constraintEqualToConstant:self.frame.size.width],
             [self.titleLabel.topAnchor constraintEqualToAnchor:self.articleImage.centerYAnchor constant:SParticleTitleTopPadding],
             [self.dateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:SParticleDateTopPadding],
             [self.ingressLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:SParticleIngressTopPadding],
             [self.contentView.bottomAnchor constraintEqualToAnchor:self.ingressLabel.bottomAnchor constant:SParticleIngressBottomPadding]];
}

- (NSArray *)landscapeConstraints {
    return @[[self.articleImage.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
             [self.ingressLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-SParticleIngressBottomPadding],
             [self.dateLabel.bottomAnchor constraintEqualToAnchor:self.ingressLabel.topAnchor constant:-SParticleIngressTopPadding],
             [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.dateLabel.topAnchor constant:-SParticleDateTopPadding]
             ];
}

- (void)activatePortrait {
    [NSLayoutConstraint deactivateConstraints:self.landscapeLayout];
    [NSLayoutConstraint activateConstraints:self.portraitLayout];
    [self setNeedsLayout];
}

- (void)activateLandscape {
    [NSLayoutConstraint deactivateConstraints:self.portraitLayout];
    [NSLayoutConstraint activateConstraints:self.landscapeLayout];
    [self setNeedsLayout];
}

#pragma mark - View Lifecycle
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)prepareForReuse {
    self.articleImage.image = nil;
    [super prepareForReuse];
}
@end
