/*!
 @header        NSDateFormatter (Category)
 @abstract      时间格式化分类，方法补充
 @brief         各种项目可复用该分类
 @discussion    类方法创建时间格式
 */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
