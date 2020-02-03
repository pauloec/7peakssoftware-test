//
//  SideMenuModel.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SideMenuItemModel <NSObject>
@end

@interface SideMenuItemModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageDetail;
@property (nonatomic, strong) NSString *identifier;
@end

@interface SideMenuModel : NSObject
@property (nonatomic, strong) NSString *backgroundImage;
@property (nonatomic, strong) NSString *logoImage;
@property (nonatomic, strong) NSString *logoName;
@property (nonatomic, strong) NSArray<SideMenuItemModel> *items;
@end
