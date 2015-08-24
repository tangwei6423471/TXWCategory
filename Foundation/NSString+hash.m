//
//  NSString+hash.m
//  JDC_IM
//
//  Created by niko on 15/1/17.
//  Copyright (c) 2015年 教导村. All rights reserved.
//

#import "NSString+hash.h"
#import <CommonCrypto/CommonDigest.h>   // 使用md5加密需要导入的头文件
@implementation NSString (hash)
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

