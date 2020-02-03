//
//  TableViewDataSource.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewBlock)(id cell, id item);

@interface TableViewDataSource : NSObject <UITableViewDataSource>
- (instancetype)initCellIdentifier:(NSString *)cellIdentifier configureCell:(TableViewBlock)cellBlock items:(NSArray *)items;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, copy) NSArray *items;
@end
