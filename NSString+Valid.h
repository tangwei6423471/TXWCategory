/*!
 @header        NSString (Valid)
 @abstract      通过NSPredicate 过滤中文之后返回结果
 @brief
 @discussion    类似数据库筛选
 */

#import <Foundation/Foundation.h>

@interface NSString (Valid)
-(BOOL)isChinese;
/**
 *  判断字符串是否转int
 *  @param string
 *  @return
 */
- (BOOL)isPureInt:(NSString *)string;
/**
 *  判断字符串是否转float
 *  @param string
 *  @return
 */
- (BOOL)isPureFloat:(NSString *)string;

/**
 *  GB2312数据转换成UTF8字符串
 *
 *  @param dataGB2312
 *
 *  @return
 */
- (NSString *)GB2312ToUTF8:(NSData *)dataGB2312;
@end
