//
//  UIImage+Helper.m
//  iOSHelper
//
//  Created by Aigo on 14-7-24.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import "UIImage+Helper.h"

// by alvin to solve warnning
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#define kCGImageAlphaPremultipliedFirst  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst)

#else

#define kCGImageAlphaPremultipliedFirst  kCGImageAlphaPremultipliedFirst

#endif

@implementation UIImage (Helper)

// 根据url获取uiimage
- (UIImage *)getImageFromURL:(NSString *)fileURL{
    
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

//复制当前图片
- (UIImage *)duplicate{
    CGImageRef newCgIm = CGImageCreateCopy(self.CGImage);
    UIImage *newImage = [UIImage imageWithCGImage:newCgIm scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(newCgIm);
    return newImage;
}

//使当前图片可拉伸
- (UIImage *)stretched{
    CGSize size = self.size;
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    return [self resizableImageWithCapInsets:insets];
}

//使当前图片抗锯齿(当图片在旋转时有用, 原理就是在图片周围加1px的透明像素)
- (UIImage *)antiAlias{
    int border = 1;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

//创建纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image stretched];
}

//imageNamed的非缓存版
+ (UIImage *)imageName:(NSString *)name{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    
    return [UIImage imageWithContentsOfFile:path];
}


+(UIImage*)screenShot{
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	
	UIGraphicsBeginImageContext(screenRect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextClearRect(ctx , screenRect);
	
	UIApplication * app = [UIApplication sharedApplication];
	UIWindow * win = [app keyWindow];
	[win.layer renderInContext:ctx];
	CGContextFlush(ctx);
	
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return img;
}


- (BOOL)imageIsJPGFromData:(NSData *)imageData
{
    if (imageData.length > 4) {
        const unsigned char * bytes = [imageData bytes];
        
        if (bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff)
        {
            return YES;
        }
        
        if (bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47)
        {
            return NO;
        }
    }
    
    return NO;
}

// 判断图片格式是否png
- (BOOL)imageIsPNGFromData:(NSData *)imageData
{
    if (imageData.length > 4) {
        const unsigned char * bytes = [imageData bytes];
        
        if (bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff)
        {
            return NO;
        }
        
        if (bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47)
        {
            return YES;
        }
    }
    
    return NO;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



#pragma mark private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
	CGContextBeginPath(context);
	CGContextSaveGState(context);
	
	if (radius == 0) {
		CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddRect(context, rect);
	} else {
		CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextScaleCTM(context, radius, radius);
		float fw = CGRectGetWidth(rect) / radius;
		float fh = CGRectGetHeight(rect) / radius;
		
		CGContextMoveToPoint(context, fw, fh/2);
		CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
		CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
		CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
		CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	}
	
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}
#pragma mark Public
- (UIColor *)colorAtPoint:(CGPoint )point{
    if (point.x < 0 || point.y < 0) return nil;
    
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height) return nil;
    
    unsigned char *rawData = malloc(height * width * 4);
    if (!rawData) return nil;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast
                                                 | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return nil;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    
    UIColor *result = nil;
    result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    free(rawData);
    return result;
}

- (BOOL)hasAlphaChannel {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage*)scaleToSize:(CGSize)size {
	UIGraphicsBeginImageContext(size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
	
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return scaledImage;
}

- (UIImage*)scaleAndCropToSize:(CGSize)size {
	if(size.height > size.width) {
		if(self.size.height > self.size.width) {
			if((self.size.width  / self.size.height) >= (size.width / size.height)) {
				return [self scaleHeightAndCropWidthToSize:size];
			} else {
				return [self scaleWidthAndCropHeightToSize:size];
			}
		} else {
			return [self scaleHeightAndCropWidthToSize:size];
		}
	} else {
		if(self.size.width > self.size.height) {
			if((self.size.height / self.size.width) >= (size.height / size.width)) {
				return [self scaleWidthAndCropHeightToSize:size];
			} else {
				return [self scaleHeightAndCropWidthToSize:size];
			}
		} else {
			return [self scaleWidthAndCropHeightToSize:size];
		}
	}
}

- (UIImage*)scaleHeightAndCropWidthToSize:(CGSize)size {
	float newWidth = (self.size.width * size.height) / self.size.height;
	return [self scaleToSize:size withOffset:CGPointMake((newWidth - size.width) / 2, 0.0f)];
}

- (UIImage*)scaleWidthAndCropHeightToSize:(CGSize)size {
	float newHeight = (self.size.height * size.width) / self.size.width;
	return [self scaleToSize:size withOffset:CGPointMake(0, (newHeight - size.height) / 2)];
}

- (UIImage*)scaleToSize:(CGSize)size withOffset:(CGPoint)offset {
	UIImage* scaledImage = [self scaleToSize:CGSizeMake(size.width + (offset.x * -2), size.height + (offset.y * -2))];
	
	UIGraphicsBeginImageContext(size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGRect croppedRect;
	croppedRect.size = size;
	croppedRect.origin = CGPointZero;
	
	CGContextClipToRect(context, croppedRect);
	
	CGRect drawRect;
	drawRect.origin = offset;
	drawRect.size = scaledImage.size;
	
	CGContextDrawImage(context, drawRect, scaledImage.CGImage);
	
	
	UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return croppedImage;
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
	BOOL clip = NO;
	CGRect originalRect = rect;
	if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
		if (contentMode == UIViewContentModeLeft) {
			rect = CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeTop) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y,
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeBottom) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeCenter) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomLeft) {
			rect = CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeBottomRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + (rect.size.height - self.size.height),
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeTopLeft) {
			rect = CGRectMake(rect.origin.x,
							  rect.origin.y,
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeTopRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y,
							  self.size.width, self.size.height);
			clip = YES;
		} else if (contentMode == UIViewContentModeScaleAspectFill) {
			CGSize imageSize = self.size;
			if (imageSize.height < imageSize.width) {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			} else {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			}
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		} else if (contentMode == UIViewContentModeScaleAspectFit) {
			CGSize imageSize = self.size;
			if (imageSize.height < imageSize.width) {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			} else {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			}
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (clip) {
		CGContextSaveGState(context);
		CGContextAddRect(context, originalRect);
		CGContextClip(context);
	}
	
	[self drawInRect:rect];
	
	if (clip) {
		CGContextRestoreGState(context);
	}
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
	[self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleToFill];
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	if (radius) {
		[self addRoundedRectToPath:context rect:rect radius:radius];
		CGContextClip(context);
	}
	
	[self drawInRect:rect contentMode:contentMode];
	
	CGContextRestoreGState(context);
}
//=====================

+ (UIImage *)updateImageOrientation:(UIImage *)chosenImage
{
    if (chosenImage) {
        // No-op if the orientation is already correct
        if (chosenImage.imageOrientation == UIImageOrientationUp){
            return chosenImage;
        }
        else{
            
            // We need to calculate the proper transformation to make the image upright.
            // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
            CGAffineTransform transform = CGAffineTransformIdentity;
            UIImageOrientation orientation=chosenImage.imageOrientation;
            int orientation_=orientation;
            switch (orientation_) {
                case UIImageOrientationDown:
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, chosenImage.size.height);
                    transform = CGAffineTransformRotate(transform, M_PI);
                    break;
                    
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, 0);
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    break;
                    
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, 0, chosenImage.size.height);
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    break;
            }
            
            switch (orientation_) {
                case UIImageOrientationUpMirrored:{
                    
                }
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
                    
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.height, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
            }
            
            // Now we draw the underlying CGImage into a new context, applying the transform
            // calculated above.
            CGContextRef ctx = CGBitmapContextCreate(NULL, chosenImage.size.width, chosenImage.size.height,
                                                     CGImageGetBitsPerComponent(chosenImage.CGImage), 0,
                                                     CGImageGetColorSpace(chosenImage.CGImage),
                                                     CGImageGetBitmapInfo(chosenImage.CGImage));
            CGContextConcatCTM(ctx, transform);
            switch (chosenImage.imageOrientation) {
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    // Grr...
                    CGContextDrawImage(ctx, CGRectMake(0,0,chosenImage.size.height,chosenImage.size.width), chosenImage.CGImage);
                    break;
                    
                default:
                    CGContextDrawImage(ctx, CGRectMake(0,0,chosenImage.size.width,chosenImage.size.height), chosenImage.CGImage);
                    break;
            }
            // And now we just create a new UIImage from the drawing context
            CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
            UIImage *img = [UIImage imageWithCGImage:cgimg];
            CGContextRelease(ctx);
            CGImageRelease(cgimg);
            return img;
        }
    }
    return nil;
}

+ (UIImage*)shrinkImage:(UIImage*)original size:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale,
                                                 size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width * scale, size.height * scale),
                       original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
}

#pragma mark - 创建mainBundle目录下不带缓存的图片
+ (UIImage *)imageNoCache:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], name]];
}

#pragma mark - 可拉伸的图片
+ (UIImage *)stretchableImage:(UIImage *)img edgeInsets:(UIEdgeInsets)edgeInsets{
    edgeInsets.top < 1 ? edgeInsets.top = 12 : 0;
    edgeInsets.left  < 1 ? edgeInsets.left = 12 : 0;
    edgeInsets.bottom < 1 ? edgeInsets.bottom = 12 : 0;
    edgeInsets.right  < 1 ? edgeInsets.right = 12 : 0;
#if defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
    return [img resizableImageWithCapInsets:edgeInsets];
#else
    return [img stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
#endif
}

+ (UIImage *)imageFromBundle:(NSString *)bundleName path:(NSString *)path imageName:(NSString *)imageName
{
    NSMutableString *fullName = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];
    if (path && path.length > 0)
    {
        [fullName appendString:@"/"];
        [fullName appendString:path];
    }
    if (imageName && imageName.length > 0)
    {
        [fullName appendString:@"/"];
        [fullName appendString:imageName];
    }
    NSLog(@"xxxxxx %@",fullName);
    return [UIImage imageWithContentsOfFile:fullName];
}


#pragma mark - UIColor转UIImage
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithView:(UIView *)view rect:(CGRect)rect
{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    if (rect.origin.x != 0 && rect.origin.x != 0) {
    //        CGImageRef imageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    //        img = [UIImage imageWithCGImage:imageRef];
    //    }
    
    return img;
}

+ (UIImage *)imageWithWindowRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    NSLog(@"%@", NSStringFromCGSize(window.bounds.size));
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, imageView.opaque, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - 将图片大小转换成新尺寸
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];//根据新的尺寸画出传过来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    UIGraphicsEndImageContext();//关闭当前环境
    return newImage;
}



#pragma mark - 将图片大小转换成新尺寸
+ (UIImage *)imageWithImageCenterSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    [image drawInRect:CGRectMake((image.size.width - newSize.width)/2.0,
                                 (image.size.height - newSize.height)/2.0,
                                 newSize.width*2,
                                 newSize.height*2)];//根据新的尺寸画出传过来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    UIGraphicsEndImageContext();//关闭当前环境
    return newImage;
}


+ (UIImage *) croppedImageCenterSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    CGSize size = CGSizeZero;
    
    if (newSize.width >= newSize.height) {
        size.width = image.size.width;
        size.height = size.width * newSize.height/newSize.width;
    }
    
    if (newSize.height >= newSize.width) {
        size.height = image.size.height;
        size.width = size.height * newSize.width/newSize.height;
    }
    
    
    
    CGRect cropRect = CGRectMake((image.size.width - size.width)/2.0,
                                 (image.size.height - size.height)/2.0,
                                 size.width,
                                 size.height);
    
    //    NSLog(@"---------- cropRect: %@", NSStringFromCGRect(cropRect));
    //    NSLog(@"--- self.photo.size: %@", NSStringFromCGSize(self.photo.size));
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    NSLog(@"------- result.size: %@", NSStringFromCGSize(result.size));
    
    return result;
}




+ (CGSize)scaleImage:(UIImage *)image sideMax:(float)sideMax
{
    if (!image)
        return CGSizeZero;
    CGSize size ;
    if (image.size.height > image.size.width)
    {
        size.height = sideMax;
        size.width = image.size.width/image.size.height*sideMax;
    }
    else
    {
        size.width = sideMax;
        size.height = image.size.height/image.size.width*sideMax;
    }
    return size;
}


@end
