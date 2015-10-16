//
//  NSObject+Throttle.m
//  qgzh
//
//  Created by niko on 15/10/15.
//  Copyright © 2015年 jiaodaocun. All rights reserved.
//

#import "NSObject+Throttle.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char WZThrottledSelectorKey;
static char WZThrottledSerialQueue;

@implementation NSObject (Throttle)

- (void)wz_performSelector:(SEL)aSelector withThrottle:(NSTimeInterval)inteval
{
    [self wz_performSelector:aSelector aParam1:nil aParam2:nil elsePerformSelector:nil bParam1:nil bParam2:nil withThrottle:inteval];
}

// 添加一个函数节流中可执行的方法
- (void)wz_performSelector:(SEL)aSelector elsePerformSelector:(SEL)bSelector withThrottle:(NSTimeInterval)inteval
{
    [self wz_performSelector:aSelector aParam1:nil aParam2:nil elsePerformSelector:bSelector bParam1:nil bParam2:nil withThrottle:inteval];
}

// 添加一个函数节流中可执行的方法,以及可传入的参数
- (void)wz_performSelector:(SEL)aSelector aParam1:(id)aParam1 aParam2:(id)aParam2 elsePerformSelector:(SEL)bSelector bParam1:(id)bParam1 bParam2:(id)bParam2 withThrottle:(NSTimeInterval)inteval
{
    dispatch_async([self getSerialQueue], ^{
        NSMutableDictionary *blockedSelectors = [objc_getAssociatedObject(self, &WZThrottledSelectorKey) mutableCopy];
        
        if (!blockedSelectors) {
            blockedSelectors = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, &WZThrottledSelectorKey, blockedSelectors, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        if (!aSelector) {return ;}
        NSString *selectorName = NSStringFromSelector(aSelector);
        if (![blockedSelectors objectForKey:selectorName]) {
            [blockedSelectors setObject:selectorName forKey:selectorName];
            objc_setAssociatedObject(self, &WZThrottledSelectorKey, blockedSelectors, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            dispatch_async(dispatch_get_main_queue(), ^{

                objc_msgSend(self, aSelector, aParam1, aParam2);
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(inteval * NSEC_PER_SEC)), [self getSerialQueue], ^{
                    [self unlockSelector:selectorName];
                });
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (bSelector) {
                    objc_msgSend(self, bSelector, bParam1, bParam2);
                }
                
            });
        }
    });
}

#pragma mark -
- (void)unlockSelector:(NSString *)selectorName
{
    dispatch_async([self getSerialQueue], ^{
        NSMutableDictionary *blockedSelectors = [objc_getAssociatedObject(self, &WZThrottledSelectorKey) mutableCopy];
        
        if ([blockedSelectors objectForKey:selectorName]) {
            [blockedSelectors removeObjectForKey:selectorName];
        }
        
        objc_setAssociatedObject(self, &WZThrottledSelectorKey, blockedSelectors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    });
}

- (dispatch_queue_t)getSerialQueue
{
    dispatch_queue_t serialQueur = objc_getAssociatedObject(self, &WZThrottledSerialQueue);
    if (!serialQueur) {
        serialQueur = dispatch_queue_create("com.jiaodaocun.throttle", NULL);
        objc_setAssociatedObject(self, &WZThrottledSerialQueue, serialQueur, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return serialQueur;
}

@end
