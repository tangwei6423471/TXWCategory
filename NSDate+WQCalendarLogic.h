//
//  Color.h
//  VIPTravel
//
//  Created by 张凡 on 14-6-6.
//  Copyright (c) 2014年 张凡. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)numberOfWeeksInCurrentMonth;

- (NSUInteger)weeklyOrdinality;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;

- (NSDate *)dayInTheFollowingMonth:(int)month;//获取当前日期之后的几个月

- (NSDate *)dayInTheFollowingDay:(int)day;//获取当前日期之后的几个天

- (NSDateComponents *)YMDComponents;

- (NSDate *)dateFromString:(NSString *)dateString;//NSString转NSDate

- (NSDate *)dateFromStringHMS:(NSString *)dateString;// NSString转NSDate hms

- (NSDate *)dateFromStringYMD:(NSString *)dateString;//NSString转NSDate 年月日

- (NSString *)stringFromDate:(NSDate *)date;//NSDate转NSString

- (NSString *)stringFromDateYMD:(NSDate *)date;//NSDate转NSString 年月日

- (NSDate *)dateFromStringTT:(NSString *)dateString;// @"2015-04-02T00:00:00"

+ (int)getMiniteNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;// 计算日期差距分钟

+ (int)getHourNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;// 计算日期差距小时

+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday; // 计算日期差距天数

+ (int)getYearNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;// 判断两个日期相隔多少年

- (int)getWeekIntValueWithDate;

- (NSString *)stringFromDateMonthDay:(NSDate *)date;//NSDate转NSString @"MM月dd日"

- (NSString *)compareIfTodayWithDate;//判断日期是今天,明天,后天,周几

+ (NSString *)getWeekStringFromInteger:(int)week;//通过数字返回星期几

- (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d;// 得到星座的算法

- (NSString *)getZodiacWithYear:(NSInteger)y;// 获得生肖

- (NSString *)stringFromDateY:(NSDate *)date;//NSDate转NSString @"年"

- (NSString *)stringFromDateM:(NSDate *)date;//NSDate转NSString @"月"

- (NSString *)stringFromDateDay:(NSDate *)date;//NSDate转NSString @"日"

- (NSString *)stringFromDateHHmm:(NSDate *)date;//NSDate转NSString 时分

+ (NSDate *)date8Hour;// 创建当前日期， 解决8小时问题了

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;// 比较两个日期大小

- (BOOL)isTheSameDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;// 判断两个日期是不是同一天

/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
@end
