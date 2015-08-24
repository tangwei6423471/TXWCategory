//
//  UIViewController+initFromStoryboard.h
//  QGZH
//
//  Created by niko on 15/3/13.
//  Copyright (c) 2015年 jdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (initFromStoryboard)

+ (instancetype)initFromStoryboard;

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;
@end
