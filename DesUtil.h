//
//  DesUtil.h
//  qgzh
//
//  Created by niko on 15/5/22.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesUtil : NSObject
/**
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv;

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv;
@end
