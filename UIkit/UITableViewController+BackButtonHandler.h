//
//  UITableViewController+BackButtonHandler.h
//  qgzh
//
//  Created by niko on 15/6/10.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)navigationShouldPopOnBackButton;
@end
@interface UITableViewController (BackButtonHandler)<BackButtonHandlerProtocol>


@end
