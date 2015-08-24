//
//  UIBarButtonItem+JC.h
//  HiPhotoFramework
//
//  Created by JerryChui on 4/29/15.
//  Copyright (c) 2015 Appsoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JC)

/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
