//
//  UIBarButtonItem+JC.m
//  HiPhotoFramework
//
//  Created by JerryChui on 4/29/15.
//  Copyright (c) 2015 Appsoon. All rights reserved.
//

#import "UIBarButtonItem+JC.h"
//#import "UIImage+FlatUI.h"
//#import "UIColor+FlatUI.h"

@implementation UIBarButtonItem (JC)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];

//    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
