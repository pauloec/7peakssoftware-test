//
//  SideMenuViewModel.h
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "SideMenuModel.h"
#import <Foundation/Foundation.h>

@interface SideMenuViewModel : NSObject
@property (nonatomic, copy, readonly) NSArray<SideMenuItemModel> *items;
@property (nonatomic, retain, readonly) NSString *backgroundImage;
@property (nonatomic, retain, readonly) NSString *logoImage;
@property (nonatomic, retain, readonly) NSString *logoName;
- (instancetype)initWithModel:(SideMenuModel *)model;
@end
