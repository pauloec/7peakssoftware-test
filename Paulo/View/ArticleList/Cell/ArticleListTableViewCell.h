//
//  ArticleListTableViewCell.h
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *articleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *ingressLabel;
- (void)activatePortrait;
- (void)activateLandscape;
@end
