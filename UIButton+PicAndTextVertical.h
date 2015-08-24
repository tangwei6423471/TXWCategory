//
//  UIButton+PicAndTextVertical.h
//  qgzh
//
//  Created by niko on 15/5/7.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

//今天完成了这个，整理为公用代码，分享一下，调用时只要设置好按钮图片和文字后，直接调用 centerImageAndTitle 即可
// 图文垂直排列

#import <UIKit/UIKit.h>

@interface UIButton (PicAndTextVertical)

- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;

@end


