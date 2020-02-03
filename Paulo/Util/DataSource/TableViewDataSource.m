//
//  TableViewDataSource.m
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewDataSource ()
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewBlock cellBlock;
@end

@implementation TableViewDataSource

- (instancetype)init {
    return nil;
}

- (instancetype)initCellIdentifier:(NSString *)cellIdentifier configureCell:(TableViewBlock)cellBlock items:(NSArray *)items {
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
        _cellBlock = cellBlock;
        _items = items;
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.cellBlock(cell, item);
    return cell;
}

@end
