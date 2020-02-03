//
//  DatabaseService.h
//  Paulo
//
//  Created by Paulo Correa on 15/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseService : NSObject
+ (NSArray *)articleListWithData:(NSDictionary *)data;
+ (NSArray *)articleListFromDatabase;
@end
