

#import "NSString+Valid.h"

@implementation NSString (Valid)
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)"; // 中文的正则表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match]; // 过滤器
    return [predicate evaluateWithObject:self]; // 返回过滤后满足条件的内容
}

/**
 *  判断字符串是否转int
 *  @param string
 *  @return
 */
- (BOOL)isPureInt:(NSString *)string{
    if (!string) {
        return NO;
    }
    NSScanner *_scanner = [NSScanner scannerWithString:string];
    int val;
    return [_scanner scanInt:&val] && [_scanner isAtEnd];
}
/**
 *  判断字符串是否转float
 *  @param string
 *  @return
 */
- (BOOL)isPureFloat:(NSString *)string{
    if (!string) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  GB2312数据转换成UTF8字符串
 *
 *  @param dataGB2312
 *
 *  @return
 */
- (NSString *)GB2312ToUTF8:(NSData *)dataGB2312{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:dataGB2312 encoding:encoding];
    return str;
}
@end
