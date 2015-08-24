//
//  NSString+version.m
//  qgzh
//
//  Created by niko on 15/5/25.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "NSString+version.h"

@implementation NSString (version)
+ (BOOL)versionString1:(NSString *)versionString1 isGreaterThanVersionString2:(NSString *)versionString2 {
    BOOL result = NO;
    result = [versionString2 compare:versionString1 options:NSNumericSearch]  == NSOrderedAscending;
    return result;
}
@end
