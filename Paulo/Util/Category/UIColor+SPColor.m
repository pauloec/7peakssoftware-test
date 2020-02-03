//
//  UIColor+SPColor.m
//  Paulo
//
//  Created by Paulo Correa on 11/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "UIColor+SPColor.h"

@implementation UIColor (SPColor)
+ (UIColor *)navigationBarColor {
    return [UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1.0];
}

+ (UIColor *)sideMenuBackgroundColor {
    return [UIColor colorWithRed:74.0/255.0f green:74.0/255.0f blue:74.0/255.0f alpha:1.0];
}

+ (UIColor *)windowBackgroundColor {
    return [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:0.76];
}

+ (UIColor *)articleDateTextColor {
    return [UIColor colorWithRed:172.0/255.0f green:172.0/255.0f blue:172.0/255.0f alpha:1.0];
}
@end
