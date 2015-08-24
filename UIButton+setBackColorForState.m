//
//  UIButton+setBackColorForState.m
//  qgzh
//
//  Created by niko on 15/5/20.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UIButton+setBackColorForState.h"

@implementation UIButton (setBackColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageFromColor:backgroundColor] forState:state];
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)MysetHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = COLOR_MAIN_GREEN;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:COLOR_MAIN_GREEN forState:UIControlStateNormal];
    }
}
@end
