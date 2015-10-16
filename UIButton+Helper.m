//
//  UIButton+Helper.m
//  iOSHelper
//
//  Created by Aigo on 14-7-24.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import "UIButton+Helper.h"
#import "UIImage+Helper.h"

@implementation UIButton (Helper)
+ (UIButton*) buttonWithTarget:(id)target action:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void) setTextN:(NSString*)n H:(NSString*)h D:(NSString*)d S:(NSString *)s{
    if ( n ){
        [self setTitle:n forState:UIControlStateNormal];
    }
    if ( h ){
        [self setTitle:h forState:UIControlStateHighlighted];
    }
    if ( d ){
        [self setTitle:d forState:UIControlStateDisabled];
    }
    if ( s ){
        [self setTitle:s forState:UIControlStateSelected];
    }
}

- (void) setImageN:(NSString*)n H:(NSString*)h D:(NSString*)d S:(NSString *)s{
    if ( n ){
        [self setImage:[UIImage imageNamed:n] forState:UIControlStateNormal];
    }
    if ( h ){
        [self setImage:[UIImage imageNamed:h] forState:UIControlStateHighlighted];
    }
    if ( d ){
        [self setImage:[UIImage imageNamed:d] forState:UIControlStateDisabled];
    }
    if ( s ){
        [self setImage:[UIImage imageNamed:s] forState:UIControlStateSelected];
        if ( h ){
            [self setImage:[UIImage imageNamed:h] forState:UIControlStateHighlighted | UIControlStateSelected];
        }
        
    }
}


- (void)setBackgroundColorNormal:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor
{
    [self setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    
    //    [self setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_highlight"] forState:UIControlStateNormal];
    //    [self setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_normal"] forState:UIControlStateHighlighted];
}


- (void)buttonWithNormalImageName:(NSString *)normalImageName
                     highlightedImageName:(NSString *)highlightedImageName
                               edgeInsets:(UIEdgeInsets)edgeInsets
                           layerImageName:(NSString *)layerImageName
                                titleName:(NSString *)titleName
                                titleFont:(float)titleFont
                                   target:(id)target
                                   action:(SEL)sel
{
    if(UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsZero))
    {
        edgeInsets = UIEdgeInsetsMake(15, 15, 15, 10);
    }
    
    if (normalImageName) {
        UIImage* image = [UIImage stretchableImage:[UIImage imageNoCache:normalImageName] edgeInsets:edgeInsets];
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if (highlightedImageName) {
        UIImage* highlightedImage = [UIImage stretchableImage:[UIImage imageNoCache:highlightedImageName] edgeInsets:edgeInsets];
        [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    if (layerImageName) {
        UIImage* layerImage = [UIImage imageNoCache:layerImageName];
        UIImageView *layerImageView = [[UIImageView alloc]initWithImage:layerImage];
        layerImageView.center = self.center;
        [self addSubview:layerImageView];
    }
    
    if (titleName) {
        [self setTitle:titleName forState:UIControlStateNormal];
        [self setTitle:titleName forState:UIControlStateHighlighted];
    }
    
    if (titleFont == 0) {
        titleFont = 12.0f;
    }
    
    self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    self.titleLabel.shadowOffset = CGSizeMake(1.0f, -1.0f);
    
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonWithSelectedImageName:(NSString*)selectedImageName
                          disabledImageName:(NSString*)disabledImageName
                                 edgeInsets:(UIEdgeInsets)edgeInsets
{
    if (selectedImageName) {
        UIImage* image = [UIImage stretchableImage:[UIImage imageNoCache:selectedImageName] edgeInsets:edgeInsets];
        [self setBackgroundImage:image forState:UIControlStateSelected];
    }
    
    if (disabledImageName) {
        UIImage* highlightedImage = [UIImage stretchableImage:[UIImage imageNoCache:disabledImageName] edgeInsets:edgeInsets];
        [self setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
    }
}

- (void)        buttonWithNormalTitleColor:(UIColor *)normalColor
                     highlightedTitleColor:(UIColor *)highlightedColor
{
    normalColor = normalColor ? normalColor : [UIColor whiteColor];
    highlightedColor = highlightedColor ? highlightedColor : [UIColor whiteColor];
    
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                       target:(id)target
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    }
    
    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    }
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// 20150921 alvin
- (void)setImageWithAnimation:(UIImage *)image forState:(UIControlState)state
{
    [self setImage:image forState:state];
    [self fireAnimationWithDuration:0.2f];
}

- (void)fireAnimationWithDuration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *animaiton = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform0 = CATransform3DMakeScale(1, 1, 1);
    CATransform3D transform1 = CATransform3DMakeScale(1.26, 1.26, 1.26);
    CATransform3D transform2 = CATransform3DMakeScale(1, 1, 1);
    NSValue *value1 = [NSValue valueWithCATransform3D:transform0];
    NSValue *value2 = [NSValue valueWithCATransform3D:transform1];
    NSValue *value3 = [NSValue valueWithCATransform3D:transform2];
    NSArray *values = @[value1, value2, value3];
    animaiton.values = values;
    animaiton.duration = duration;
    animaiton.repeatCount = 0;      //    #define    HUGE_VALF    1e50f
    
    [self.layer addAnimation:animaiton forKey:@"AnimationForTransform"];
}

@end
