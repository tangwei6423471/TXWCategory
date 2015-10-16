//
//  UIButton+redDot.h
//  qgzh
//
//  Created by niko on 15/9/2.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (redDot)
- (void)showBadgeOnItemIndex;   //显示小红点
- (void)hideBadgeOnItemIndex; //隐藏小红点
- (void)showBadgeOnItemIndexWithFrame:(CGRect)frame;   //显示小红点
@end
