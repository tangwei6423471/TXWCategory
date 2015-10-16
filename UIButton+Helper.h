//
//  UIButton+Helper.h
//  iOSHelper
//
//  Created by Aigo on 14-7-24.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)
+ (UIButton*) buttonWithTarget:(id)target action:(SEL)sel;

- (void) setTextN:(NSString*)n H:(NSString*)h D:(NSString*)d S:(NSString *)s;
- (void) setImageN:(NSString*)n H:(NSString*)h D:(NSString*)d S:(NSString *)s;

- (void)setBackgroundColorNormal:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;

- (void)buttonWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName edgeInsets:(UIEdgeInsets)edgeInsets layerImageName:(NSString *)layerImageName titleName:(NSString *)titleName titleFont:(float)titleFont target:(id)target action:(SEL)sel;

- (void)buttonWithSelectedImageName:(NSString*)selectedImageName disabledImageName:(NSString*)disabledImageName edgeInsets:(UIEdgeInsets)edgeInsets;

- (void)buttonWithNormalTitleColor:(UIColor *)normalColor highlightedTitleColor:(UIColor *)highlightedColor;

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;

// 20150921 alvin
- (void)setImageWithAnimation:(UIImage *)image forState:(UIControlState)state;
@end
