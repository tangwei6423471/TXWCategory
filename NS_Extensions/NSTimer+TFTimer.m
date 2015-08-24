//
//  NSTimer+TFTimer.m
//  Lanove
//
//  Created by admin on 15/2/11.
//  Copyright (c) 2015年 terry.tgq. All rights reserved.
//

#import "NSTimer+TFTimer.h"

@implementation NSTimer (TFTimer)

-(void)pauseTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
    
    
}


-(void)resumeTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
    
}


@end
