//
//  UIButton+redDot.m
//  qgzh
//
//  Created by niko on 15/9/2.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UIButton+redDot.h"

@implementation UIButton (redDot)
- (void)showBadgeOnItemIndex
{
    //移除之前的小红点
    [self removeBadgeOnItemIndex];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 8888;
    badgeView.layer.cornerRadius = 3;
    badgeView.backgroundColor = [UIColor redColor];
    
    //确定小红点的位置
    CGFloat defaultOriginX = 0;
    defaultOriginX = self.frame.size.width-5;
    badgeView.frame = CGRectMake(defaultOriginX, 4, 6, 6);
    [self addSubview:badgeView];
    
}

- (void)showBadgeOnItemIndexWithFrame:(CGRect)frame
{
    [self removeBadgeOnItemIndex];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 8888;
    badgeView.layer.cornerRadius = frame.size.width/2;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.frame = frame;
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex
{
    //移除小红点
    [self removeBadgeOnItemIndex];
    
}

- (void)removeBadgeOnItemIndex
{
    
    for (UIView *subview in self.subviews) {
        if (subview.tag == 8888) {
            [subview removeFromSuperview];
        }
    }
}


@end
