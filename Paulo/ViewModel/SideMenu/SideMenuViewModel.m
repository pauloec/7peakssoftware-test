//
//  SideMenuViewModel.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "SideMenuViewModel.h"

@interface SideMenuViewModel ()
@property (nonatomic, copy, readwrite) NSArray<SideMenuItemModel> *items;
@property (nonatomic, retain, readwrite) NSString *backgroundImage;
@property (nonatomic, retain, readwrite) NSString *logoImage;
@property (nonatomic, retain, readwrite) NSString *logoName;
@end

@implementation SideMenuViewModel
- (instancetype)initWithModel:(SideMenuModel *)model {
    self = [super init];
    if (self) {
        _items = model.items;
        _backgroundImage = model.backgroundImage;
        _logoImage = model.logoImage;
        _logoName = model.logoName;
    }
    return self;
}
@end
