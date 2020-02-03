//
//  Router.h
//  Paulo
//
//  Created by Paulo Correa on 12/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RouterService : NSObject
+ (UIViewController *)viewControllerForIdentifier:(NSString *)identifier data:(NSDictionary *)data;
@end
