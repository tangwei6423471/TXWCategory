//
//  UITableViewController+initFromStoryboard.m
//  qgzh
//
//  Created by niko on 15/5/7.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "UITableViewController+initFromStoryboard.h"

@implementation UITableViewController (initFromStoryboard)
+ (instancetype)initFromStoryboard {
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id result = [loginSB instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return result;
}
@end
