//
//  NSString+Calendar.m
//  qgzh
//
//  Created by develop on 15/8/18.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "NSString+Calendar.h"

@implementation NSString (Calendar)



- (NSString *)chinaMonthByIndex:(int)index{

    if (index>12 || index<1) {
        return @"";
    }
    NSArray *chineseMonths=[NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月", nil];
    return chineseMonths[index-1];
}
- (NSString *)chinaDayByIndex:(int)index{

    if (index>30 || index<1) {
        return @"";
    }
    NSArray *chineseDays=[NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    return chineseDays[index-1];
}
@end
