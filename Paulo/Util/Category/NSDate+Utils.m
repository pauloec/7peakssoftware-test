//
//  NSDate+Utils.m
//  Paulo
//
//  Created by Paulo Correa on 16/03/18.
//  Copyright © 2018 Seven Peaks Software. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
+ (NSString *)dateFromTimestamp:(int64_t)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateComponents *dateFromTimestamp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSDateComponents *dateFromSystem = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    BOOL is12h = [dateFormat containsString:@"a"];
    
    NSMutableString *dateFormatString = [NSMutableString new];
    [dateFormatString appendString:@"dd MMMM"];
    if ([dateFromTimestamp year] == [dateFromSystem year]) {
        [dateFormatString appendString:@", "];
    } else {
        [dateFormatString appendString:@" YYYY, "];
    }
    if (is12h) {
        [dateFormatString appendString:@"hh:mm a"];
    } else {
        [dateFormatString appendString:@"HH:mm"];
    }
    [dateFormatter setDateFormat:dateFormatString];
    return [dateFormatter stringFromDate:date];
}
@end
