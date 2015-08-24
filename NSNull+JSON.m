//
//  NSNull+JSON.m
//  qgzh
//
//  Created by niko on 15/3/29.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//


// 解析服务器json数据的时候 返回null报错 这个分类用来解决这个问题

#import "NSNull+JSON.h"

@implementation NSNull (JSON)
- (NSUInteger)length { return 0; }

- (NSInteger)integerValue { return 0; }

- (float)floatValue { return 0; }

- (NSString *)description { return @"0(NSNull)"; }

- (NSArray *)componentsSeparatedByString:(NSString *)separator { return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

- (BOOL)isEqualToString:(NSString *)compare {
    
    if ([compare isKindOfClass:[NSNull class]] || !compare) {
        DLog(@"NSNull isKindOfClass called!");
        return YES;
    }
    
    return NO;
}

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet{
    NSRange nullRange = {NSNotFound, 0};
    return nullRange;
}
/**
 *  20150407 alvin
 *
 */
- (BOOL)getBytes:(void *)buffer
              maxLength:(NSUInteger)maxBufferCount
             usedLength:(NSUInteger *)usedBufferCount
               encoding:(NSStringEncoding)encoding
                options:(NSStringEncodingConversionOptions)options
                  range:(NSRange)range
  remainingRange:(NSRangePointer)leftover{
    return NO;
}

// -[NSNull stringByTrimmingCharactersInSet:] bug alvin
- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set
{
    return @"";
}

- (NSString *)substringWithRange:(id *)range
{
    return @"0";
}

- (NSString *)_fastCharacterContents
{
    return @"";
}

- (NSString *)substringFromIndex:(id)index
{
    return @"";
}

- (int)intValue{
    return 0;
}
@end
