//
//  NSString+Helper.m
//  iOSHelper
//
//  Created by Aigo on 14-7-24.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSNumber+Helper.h"
#import "Macro.h"
#import "PhotoLabelModel.h"

@implementation NSString (Helper)
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (BOOL)isNotBlank{
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)equals:(NSString *)str{
    return [self compare:str] == NSOrderedSame;
}

- (CGFloat)heightByFont:(UIFont *)font width:(CGFloat)width{
    if (isAfterIOS6) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil].size.height;
    }else{
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping].height;
    }

}
- (CGSize)sizeByFont:(UIFont *)font width:(CGFloat)width{
    if (isAfterIOS6) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil].size;
    }else{
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
}

- (NSInteger)TextLength{
    float number = 0.0;
    for (int index = 0; index < [self length]; index++){
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3){
            number++;
        }else{
            number = number + 0.5;
        }
    }
    return ceil(number);
}

- (NSNumber*)numberValue{
    return [NSNumber numberWithString:self];
}

- (NSData *)dataValue{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  Alvin 根据枚举值 返回指定的关系 名称
 *
 *  @param relation 整形
 *
 *  @return 字符串
 */
//+ (NSString *)stringByRelation:(NSInteger)relation
//{
//    NSString *str;
//    switch (relation) {
//        case kRelationTypeSpecial:
//            str = @"特别的人";
//            break;
//        case kRelationTypeFamily:
//            str = @"家人";
//            break;
//        case kRelationTypeFriend:
//            str = @"朋友";
//            break;
//        case kRelationTypeColleague:
//            str = @"同事";
//            break;
//        case kRelationTypeNone:
//            str = @"未分组好友";
//            break;
//        default:
//            break;
//    }
//    return str;
//}

/**
 *  是否包含某字符串 alvin
 *
 *  @param motherString 母字符串
 *  @param sonString    子字符串
 *
 *  @return 布尔值
 */
+(BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString{
    if ([motherString isKindOfClass:[NSNull class]]) {
        motherString = @"";
    }
    if ([motherString rangeOfString:sonString].location!=NSNotFound) {
        
        return YES;
    }else {
        return NO;
    }
}

// 去掉所有空格 换行符
+ (NSString *)removeSpaceAndNewline:(NSString *)str;
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

// json

+ (NSString *)jsonStringWithString:(NSString *)string{
    return [NSString stringWithFormat:@"\"%@\"",[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]];
}

+ (NSString *)jsonStringWithNSDate:(NSDate *)date{
    
    NSString *string = [[NSDate new] stringFromDate:date];
    return [NSString stringWithFormat:@"\"%@\"",[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]];
}

+ (NSString *)jsonStringWithNSNumber:(NSNumber *)num isFloat:(BOOL)isFloat{
    
    NSString *string;
    if (isFloat) {
        string = [NSString stringWithFormat:@"%f",[num floatValue]];
    }else{
        string = [NSString stringWithFormat:@"%d",[num intValue]];
    }
    
    return [NSString stringWithFormat:@"\"%@\"",[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value;
        if ([name isEqualToString:@"X"] || [name isEqualToString:@"Y"]) {
            value = [NSString jsonStringWithNSNumber:valueObj isFloat:YES];
        }else{
            value = [NSString jsonStringWithObject:valueObj];
        }
        
//        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
//        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *)jsonStringWithObject:(id)object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }else if([object isKindOfClass:[NSDate class]]){
        value = [NSString jsonStringWithNSDate:object];
    }else if([object isKindOfClass:[NSNumber class]]){
        value = [NSString jsonStringWithNSNumber:object isFloat:NO];
    }else if ([object isKindOfClass:[PhotoLabelModel class]]){
        PhotoLabelModel *model = (PhotoLabelModel *)object;
        value = [NSString jsonStringWithDictionary:model.dic];
    }
    return value;
}
@end
