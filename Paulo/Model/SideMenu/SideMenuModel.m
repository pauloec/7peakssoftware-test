//
//  SideMenuModel.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "SideMenuModel.h"

@implementation SideMenuItemModel
- (instancetype)initWithTitle:(NSString *)title imageDetail:(NSString *)imageDetail identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _title = title;
        _imageDetail = imageDetail;
        _identifier = identifier;
    }
    return self;
}
@end

@implementation SideMenuModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundImage = @"background";
        _logoName = @"LOGOTEXT";
        _logoImage = @"logo";
        SideMenuItemModel *carItem = [[SideMenuItemModel alloc] initWithTitle:@"Cars" imageDetail:@"menuItemCarsActive" identifier:@"articleListViewController"];
        SideMenuItemModel *otherItem = [[SideMenuItemModel alloc] initWithTitle:@"Other" imageDetail:@"menuItemOtherInactive" identifier:@"placeholderViewController"];
        _items = [NSArray <SideMenuItemModel> arrayWithObjects:carItem, otherItem, nil];
    }
    return self;
}
@end
