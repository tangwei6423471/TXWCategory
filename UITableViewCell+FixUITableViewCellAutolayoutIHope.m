//
//  UITableViewCell+FixUITableViewCellAutolayoutIHope.m
//  qgzh
//
//  Created by niko on 15/4/20.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UITableViewCell+FixUITableViewCellAutolayoutIHope.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITableViewCell (FixUITableViewCellAutolayoutIHope)

+ (void)load{

    Method existing = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method new = class_getInstanceMethod(self, @selector(_autolayout_replacementLayoutSubviews));
    method_exchangeImplementations(existing, new);
    
}

// alvin 20150729 注释
- (void)_autolayout_replacementLayoutSubviews{
    [super layoutSubviews];
    [self _autolayout_replacementLayoutSubviews]; // not recursive due to method swizzling
    [super layoutSubviews]; 
}

@end
