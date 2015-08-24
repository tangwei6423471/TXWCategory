//
//  UIImageView+extensions.m
//  SMARTRACK
//
//  Created by admin on 13-7-5.
//  Copyright (c) 2013年 terry.tgq. All rights reserved.
//

#import "UIImageView+extensions.h"
#import "AFNetworking.h"
#import "NS_Extensions/NSString_Extensions.h"

#define ImageCachePath  [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/images/"]


@implementation UIImageView (extensions)


- (void)setUrl:(NSURL *)url
{
    if(url == nil)
        return;
    [self sd_setImageWithURL:url];
}

+ (void)setImageCaches
{
    [UIImageView setSharedImageCache:[[CUImageCache alloc] init]];
}

@end


@implementation CUImageCache
/**
 Returns a cached image for the specififed request, if available.
 
 @param request The image request.
 
 @return The cached image.
 */
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request
{
    NSString *filePath = [CUImageCache getFilePath:[request URL]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

/**
 Caches a particular image for the specified request.
 
 @param image The image to cache.
 @param request The request to be used as a cache key.
 */
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    NSString *filePath = [CUImageCache getFilePath:[request URL]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
}

+ (NSString *)getFilePath:(NSURL *)url
{
    if (url.pathComponents == nil) {
        return @"";
    }
//    if (url.pathComponents.count == 0) {
//        return @"";
//    }
    NSMutableString *filePath = [NSMutableString stringWithString:@""];
    for (int i = 1; i < (url.pathComponents.count - 1); i++)
    {
        [filePath appendString:[[url.pathComponents objectAtIndex:i] stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    }
    if(filePath.length > 0)
        [filePath appendString:@"_"];
    [filePath appendString:url.lastPathComponent];
    
    NSString *fileCachePath = [ImageCachePath stringByAppendingPathComponent:filePath];
    [[fileCachePath stringByDeletingPathExtension] directoryExists];
    
    return fileCachePath;
}

+ (NSString *)getFilePathWithUrl:(NSString *)urlStr
{
   return [CUImageCache getFilePath:[NSURL URLWithString:urlStr]];
}

+ (UIImage *)getImageloadFileWithUrl:(NSString *)urlStr
{
    NSString *filePath = [CUImageCache getFilePathWithUrl:urlStr];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end