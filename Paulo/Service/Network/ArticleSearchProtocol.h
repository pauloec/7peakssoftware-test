//
//  ArticleSearchProtocol.h
//  Paulo
//
//  Created by Paulo Correa on 10/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@protocol ArticleSearchProtocol <NSObject>
- (RACSignal *)articleSearchSignal;
@end
