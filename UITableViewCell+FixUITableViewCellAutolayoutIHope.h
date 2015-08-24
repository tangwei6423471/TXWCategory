//
//  UITableViewCell+FixUITableViewCellAutolayoutIHope.h
//  qgzh
//
//  Created by niko on 15/4/20.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (FixUITableViewCellAutolayoutIHope)

+ (void)load;

- (void)_autolayout_replacementLayoutSubviews;
@end
