//
//  UIButton+Underline.m
//  qgzh
//
//  Created by niko on 15/7/14.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UIButton+Underline.h"

@implementation UIButton (Underline)

- (void)addUnderLineWithColor:(UIColor *)color{
    
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat descender = self.titleLabel.font.descender;
    if([color isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, color.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}
@end
