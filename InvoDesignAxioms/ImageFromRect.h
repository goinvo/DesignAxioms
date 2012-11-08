//
//  ImageFromRect.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/30/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFromRect : UIImage

+ (UIImage *)imageWithName:(NSString *)name size:(CGSize)imgSize;

+(UIImage *)imagewithShadow:(NSString *)imgName;

+(UIImage *)imageOfColor:(UIColor*)imgColor size:(CGSize)imgSize;
@end
