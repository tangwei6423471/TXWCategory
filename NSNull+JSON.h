//
//  NSNull+JSON.h
//  qgzh
//
//  Created by niko on 15/3/29.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (JSON)
- (NSUInteger)length;

- (NSInteger)integerValue;

- (float)floatValue;

- (NSString *)description;

- (NSArray *)componentsSeparatedByString:(NSString *)separator;

- (id)objectForKey:(id)key;

- (BOOL)boolValue;

- (BOOL)isEqualToString:(NSString *)compare;

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet;

- (BOOL)getBytes:(void *)buffer
       maxLength:(NSUInteger)maxBufferCount
      usedLength:(NSUInteger *)usedBufferCount
        encoding:(NSStringEncoding)encoding
         options:(NSStringEncodingConversionOptions)options
           range:(NSRange)range
  remainingRange:(NSRangePointer)leftover;

- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set;


- (NSString *)substringWithRange:(id *)range;
- (NSString *)substringFromIndex:(id)index;
- (NSString *)_fastCharacterContents;

- (int)intValue;
@end
