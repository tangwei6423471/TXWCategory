//
//  NSObject+Throttle.h
//  qgzh
//
//  Created by niko on 15/10/15.
//  Copyright © 2015年 jiaodaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Throttle)

- (void)wz_performSelector:(SEL)aSelector withThrottle:(NSTimeInterval)inteval;
// alvin 201510161022 增加一个不满足执行条件的执行方法，比如刷新的时候关闭刷新
- (void)wz_performSelector:(SEL)aSelector elsePerformSelector:(SEL)bSelector withThrottle:(NSTimeInterval)inteval;
// alvin 201510161022 添加一个函数节流中可执行的方法,以及可传入的参数
- (void)wz_performSelector:(SEL)aSelector aParam1:(id)aParam1 aParam2:(id)aParam2 elsePerformSelector:(SEL)bSelector bParam1:(id)bParam1 bParam2:(id)bParam2 withThrottle:(NSTimeInterval)inteval;
@end