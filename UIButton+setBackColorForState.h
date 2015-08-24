//
//  UIButton+setBackColorForState.h
//  qgzh
//
//  Created by niko on 15/5/20.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (setBackColorForState)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageFromColor:(UIColor *)color;
- (void)MysetHighlighted:(BOOL)highlighted; // 背景色
@end
