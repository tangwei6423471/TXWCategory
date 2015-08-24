//
//  NSString+Calendar.h
//  qgzh
//
//  Created by develop on 15/8/18.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Calendar)
- (NSString *)chinaMonthByIndex:(int)index;
- (NSString *)chinaDayByIndex:(int)index;
@end
