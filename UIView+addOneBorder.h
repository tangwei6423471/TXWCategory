//
//  UIView+addOneBorder.h
//  qgzh
//
//  Created by niko on 15/8/3.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (addOneBorder)

- (CALayer *)prefix_addOneBorder:(UIRectEdge)edge color:(UIColor *)color thickness:(CGFloat)thickness;
@end
