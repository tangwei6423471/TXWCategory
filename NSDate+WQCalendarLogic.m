//
//  Color.h
//  VIPTravel
//
//  Created by 张凡 on 14-6-6.
//  Copyright (c) 2014年 张凡. All rights reserved.
//


#import "NSDate+WQCalendarLogic.h"

@implementation NSDate (WQCalendarLogic)


/*计算这个月有多少天*/
- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}


//获取这个月有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}



/*计算这个月的第一天是礼拜几*/
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}



//计算这个月最开始的一天
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}


- (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

//上一个月
- (NSDate *)dayInThePreviousMonth
{

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    if (!self) {
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    }else{
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    }
    
}

//下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    if (!self) {
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    }else{
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    }
}


//获取当前日期之后的几个月
- (NSDate *)dayInTheFollowingMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    if (!self) {
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    }else{
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    }
}

//获取当前日期之后的几个天
- (NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    if (!self) {
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    }else{
        return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    }
}

//获取年月日对象
- (NSDateComponents *)YMDComponents
{
    return [[NSCalendar currentCalendar] components:
            NSYearCalendarUnit|
            NSMonthCalendarUnit|
            NSDayCalendarUnit|
            NSWeekdayCalendarUnit fromDate:self];
}

//-----------------------------------------
//
//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    // 相差8小时，再转一次
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate = [destDate dateByAddingTimeInterval:interval];
    
    return localeDate;
    
}

//NSString转NSDate
- (NSDate *)dateFromStringYMD:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy年MM月dd日"];
//    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
//    [dateFormatter setTimeZone:localZone];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    // 相差8小时，再转一次
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate = [destDate dateByAddingTimeInterval:interval];
    
    return localeDate;
    
}



- (NSDate *)dateFromStringHMS:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    // 相差8小时，再转一次
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate = [destDate dateByAddingTimeInterval:interval];
    
    return localeDate;
    
}

- (NSDate *)dateFromStringTT:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ssZ"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss"];
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    if (!dateString) {
        dateString = @"2000-01-01'T'01:01:01";
    }
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    // 相差8小时，再转一次
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate = [destDate dateByAddingTimeInterval:interval];
    
    return localeDate;
    
}

//NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date
{
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。

    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];// 使用什么时区转字符串 解决8小时之差
    NSDateFormatter *toTZ = [[NSDateFormatter alloc]init];
    [toTZ setTimeZone:sourceTimeZone];
    [toTZ setDateFormat:@"yyyy.MM.dd"];
    NSString *result = [toTZ stringFromDate:date];

    
    return result;
}

//NSDate转NSString
- (NSString *)stringFromDateHHmm:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //    [dateFormatter setDateFormat:@"MM月dd日"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


//NSDate转NSString
- (NSString *)stringFromDateYMD:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    //    [dateFormatter setDateFormat:@"MM月dd日"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//NSDate转NSString @"MM月dd日"
- (NSString *)stringFromDateMonthDay:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"MM月dd日"];
    //    [dateFormatter setDateFormat:@"MM月dd日"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//NSDate转NSString @"年"
- (NSString *)stringFromDateY:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//NSDate转NSString @"月"
- (NSString *)stringFromDateM:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"MM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//NSDate转NSString @"月"
- (NSString *)stringFromDateDay:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark - 相隔分钟，小时，天，年

+ (int)getMiniteNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//日历控件对象
    if (!beforday) {
        beforday = [NSDate date];
    }
    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
    [temp setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *todayStr = [[NSDate new] stringFromDateHHmm:today];
    //    DLog(@"todayStr:%@",todayStr);
    NSString *beforeStr = [[NSDate new] stringFromDateHHmm:beforday];
//    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
//    [temp setDateFormat:@"HH:mm"];
//    
//    NSString *todayStr = [[NSDate new] stringFromDateHHmm:today];
//    //    DLog(@"todayStr:%@",todayStr);
//    NSString *beforeStr = [[NSDate new] stringFromDateHHmm:beforday];
    //    DLog(@"beforeStr:%@",beforeStr);
    NSDate *stDt = [temp dateFromString:todayStr];
    NSDate *endDt =  [temp dateFromString:beforeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:stDt];
    stDt = [stDt dateByAddingTimeInterval: interval];
    
    interval = [zone secondsFromGMTForDate:endDt];
    endDt = [endDt dateByAddingTimeInterval:interval];
    
    unsigned int unitFlags = NSMinuteCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:stDt  toDate:endDt  options:0];
    NSInteger minute = [comps minute];
    return (int)minute>=0 ? (int)minute:(-(int)minute) ;

}

+ (int)getHourNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//日历控件对象
    if (!beforday) {
        beforday = [NSDate date];
    }
    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
    [temp setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *todayStr = [[NSDate new] stringFromDateHHmm:today];
    //    DLog(@"todayStr:%@",todayStr);
    NSString *beforeStr = [[NSDate new] stringFromDateHHmm:beforday];
    
//    [temp setDateFormat:@"HH:mm"];
//    
//    NSString *todayStr = [[NSDate new] stringFromDateHHmm:today];
//    //    DLog(@"todayStr:%@",todayStr);
//    NSString *beforeStr = [[NSDate new] stringFromDateHHmm:beforday];
    //    DLog(@"beforeStr:%@",beforeStr);
    NSDate *stDt = [temp dateFromString:todayStr];
    NSDate *endDt =  [temp dateFromString:beforeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:stDt];
    stDt = [stDt dateByAddingTimeInterval: interval];
    
    interval = [zone secondsFromGMTForDate:endDt];
    endDt = [endDt dateByAddingTimeInterval:interval];
    
    unsigned int unitFlags = NSHourCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:stDt  toDate:endDt  options:0];
    NSInteger hour = [comps hour];
    return (int)hour>=0 ? (int)hour:(-(int)hour) ;
    
}


+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//日历控件对象
    if (!beforday) {
        beforday = [NSDate date];
    }
    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
    [temp setDateFormat:@"yyyy.MM.dd"];
    
    NSString *todayStr = [[NSDate new] stringFromDate:today];
//    DLog(@"todayStr:%@",todayStr);
    NSString *beforeStr = [[NSDate new] stringFromDate:beforday];
//    DLog(@"beforeStr:%@",beforeStr);
    NSDate *stDt = [temp dateFromString:todayStr];
    NSDate *endDt =  [temp dateFromString:beforeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:stDt];
    stDt = [stDt dateByAddingTimeInterval: interval];
    
    interval = [zone secondsFromGMTForDate:endDt];
    endDt = [endDt dateByAddingTimeInterval:interval];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:stDt  toDate:endDt  options:0];
    NSInteger day = [comps day];
    return (int)day>=0 ? (int)day:(-(int)day) ;

}

+ (int)getYearNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    if (!beforday) {
        beforday = [NSDate date];
    }

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//日历控件对象
    NSDateFormatter *temp = [[NSDateFormatter alloc] init];
    [temp setDateFormat:@"yyyy"];
    
    NSString *todayStr = [[NSDate new] stringFromDateY:today];
    //    DLog(@"todayStr:%@",todayStr);
    NSString *beforeStr = [[NSDate new] stringFromDateY:beforday];
    //    DLog(@"beforeStr:%@",beforeStr);
    NSDate *stDt = [temp dateFromString:todayStr];
    NSDate *endDt =  [temp dateFromString:beforeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:stDt];
    stDt = [stDt dateByAddingTimeInterval: interval];
    
    interval = [zone secondsFromGMTForDate:endDt];
    endDt = [endDt dateByAddingTimeInterval:interval];
    
    unsigned int unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:stDt  toDate:endDt  options:0];
    NSInteger year = [comps year];
    return (int)year>=0 ? (int)year:(-(int)year);
}


//周日是“1”，周一是“2”...
-(int)getWeekIntValueWithDate
{
    int weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:self];
    return weekIntValue = (int)[comps weekday];
}




//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:self];
    
    
    //获取星期对应的数字
    int weekIntValue = [self getWeekIntValueWithDate];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        return @"今天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        return @"明天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        return @"后天";
        
    }else{
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekIntValue];//周几
    }
}



//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}



//得到星座的算法
- (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [result stringByAppendingString:@"座"];
    
}


// 获得生肖
- (NSString *)getZodiacWithYear:(NSInteger)y{
    if (y <0) {
        return @"错误日期格式!!!";
    }
    
    NSString *zodiacString = @"鼠牛虎兔龙蛇马羊猴鸡狗猪";
    
    NSRange range = NSMakeRange ((y+9)%12-1, 1);
    
    NSString*  result = [zodiacString  substringWithRange:range];
    
    return [result stringByAppendingString:@""];
    
}


// 创建当前日期， 解决8小时问题了
+ (NSDate *)date8Hour{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

/**
 *  比较两个日期大小
 *
 *  @param oneDay
 *  @param anotherDay
 *
 *  @return
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}


/**
 *  判断两个日期是不是同一天
 *
 *  @param oneDat
 *  @param anotherDay
 *
 *  @return 布尔值
 */
- (BOOL)isTheSameDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if ((int)(([oneDay timeIntervalSince1970] + timezoneFix)/(24*3600)) - (int)(([anotherDay timeIntervalSince1970] + timezoneFix)/(24*3600))== 0){
        return YES;
    }else{
        return NO;
    }
}


/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [self getCustomDateWithHour:8];
    NSDate *date23 = [self getCustomDateWithHour:23];
    
    NSDate *currentDate = [NSDate date8Hour];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date8Hour];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

@end
