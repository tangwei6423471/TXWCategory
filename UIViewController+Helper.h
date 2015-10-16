//
//  UIViewController+Helper.h
//  iOSHelper
//
//  Created by Aigo on 14-7-25.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

// 自动pop或者dismiss当前viewController
- (void)dismissThisViewController;

// 检查手机号码是否是正确的 alvin
- (BOOL)isMobileNumber:(NSString *)mobileNum;

// 检查邮箱地址是否正确 alvin
- (BOOL)validateEmail: (NSString *) candidate;
@end
