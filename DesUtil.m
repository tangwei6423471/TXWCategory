//
//  DesUtil.m
//  qgzh
//
//  Created by niko on 15/5/22.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "DesUtil.h"

#import <CommonCrypto/CommonCryptor.h>
#import "ConverUtil.h"
@implementation DesUtil


//static Byte iv[] = {1,2,3,4,5,6,7,8};
/*
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key iv:(NSString *)iv
{
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [clearText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          [iv UTF8String],
                                          [textData bytes]  , dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES加密成功");
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        Byte* bb = (Byte*)[data bytes];
        ciphertext = [ConverUtil parseByteArray2HexString:bb];
    }else{
        NSLog(@"DES加密失败");
    }
    return ciphertext;
}

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv
{
    NSString *cleartext = nil;
    NSData *textData = [ConverUtil parseHexToByteArray:plainText];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          [iv UTF8String],
                                          [textData bytes]  , dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES解密成功");
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        cleartext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"DES解密失败");
    }
    return cleartext;
}
@end
