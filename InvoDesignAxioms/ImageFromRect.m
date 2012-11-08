//
//  ImageFromRect.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/30/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import "ImageFromRect.h"

@implementation ImageFromRect

+ (UIImage *)imageWithName:(NSString *)name size:(CGSize)imgSize {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imgSize.width, imgSize.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    UIImage *image = [UIImage imageNamed:[name copy]];
    [image drawInRect:rect];
    
    UIGraphicsEndImageContext();
    
    return image;
}


+(UIImage *)imagewithShadow:(NSString *)imgName{
    
    UIImage *img = [UIImage imageNamed:[imgName copy]];
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, 72 + 4, 72 + 4, CGImageGetBitsPerComponent(img.CGImage), 0,
                                                       colourSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(1, -1), 2.0, [UIColor colorWithRed:0.83f green:0.71f blue:0.57f alpha:1.00f].CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(2, 2, 72, 72), img.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

+(UIImage *)imageOfColor:(UIColor*)imgColor size:(CGSize)imgSize{

    CGRect rect = CGRectMake(0.0f, 0.0f, imgSize.width, imgSize.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [imgColor setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}

@end
