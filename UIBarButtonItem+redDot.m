//
//  UIBarButtonItem+redDot.m
//  qgzh
//
//  Created by niko on 15/4/27.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UIBarButtonItem+redDot.h"

@implementation UIBarButtonItem (redDot)




- (void)showBadgeOnItemIndex{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888;
    badgeView.layer.cornerRadius = 3;
    badgeView.backgroundColor = [UIColor redColor];
    
    //确定小红点的位置

    
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width/2+5;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width/2+5;
    }
    badgeView.frame = CGRectMake(defaultOriginX, 4, 6, 6);
    [superview addSubview:badgeView];

    
}

- (void)hideBadgeOnItemIndex{
    
    //移除小红点
    [self removeBadgeOnItemIndex];
    
}

- (void)removeBadgeOnItemIndex{
    
    //按照tag值进行移除
//    for (UIView *subView in self.subviews) {
//        
//        if (subView.tag == 888) {
//            
//            [subView removeFromSuperview];
//            
//        }
//    }
    
    UIView *superview = nil;
    if (self.customView) {
        superview = self.customView;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
    }
    
    for (UIView *subview in superview.subviews) {
        if (subview.tag == 888) {
            [subview removeFromSuperview];
        }
    }

}




@end

