//
//  UIViewController+initFromStoryboard.m
//  QGZH
//
//  Created by niko on 15/3/13.
//  Copyright (c) 2015年 jdc. All rights reserved.
//

#import "UIViewController+initFromStoryboard.h"

@implementation UIViewController (initFromStoryboard)

+ (instancetype)initFromStoryboard {
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id result = [loginSB instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return result;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
