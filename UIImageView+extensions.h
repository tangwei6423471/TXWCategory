//
//  UIImageView+extensions.h
//  SMARTRACK
//
//  Created by admin on 13-7-5.
//  Copyright (c) 2013年 terry.tgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"

@interface UIImageView (extensions)

- (void)setUrl:(NSURL *)url;

+ (void)setImageCaches;

@end

@interface CUImageCache:NSObject<AFImageCache>

+ (NSString *)getFilePath:(NSURL *)url;
+ (NSString *)getFilePathWithUrl:(NSString *)urlStr;
+ (UIImage *)getImageloadFileWithUrl:(NSString *)urlStr;
@end