//
//  InvoCardDetailViewController.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoFlipViewController.h"

@protocol DetailViewDelegate <NSObject>

-(CGPoint)getPositionOf:(NSString *)imageName;
-(void)hideImg:(NSString *)imageName;
-(void)unhideImg:(NSString *)imageName;
-(void)mainScrollviewYOffset:(CGPoint)newY;
-(void)enableParentTouches;
@end

@interface InvoCardDetailViewController : UIViewController <UIGestureRecognizerDelegate,UIScrollViewDelegate,FlipViewDelegate>

@property (nonatomic, assign)id <DetailViewDelegate>delegate;

+(InvoCardDetailViewController *)detailViewWithArray:(NSArray *)array startIndex:(int)index;


@end
