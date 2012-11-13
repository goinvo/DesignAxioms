//
//  ImageFromRect.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/30/12.

//  Copyright 2012 Involution Studios

//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.


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
