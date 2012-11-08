//
//  InvoFlipViewController.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/22/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipViewDelegate <NSObject>

-(void)dismiss;
-(void)setSccrollFrame:(CGPoint)offset scaleXY:(float)scale;
-(void)setContentOffset:(CGPoint)newOffset;

-(void)askParentToHide:(NSString *)img;
-(void)askParentToUnHide:(NSString *)img;
@end

@interface InvoFlipViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, assign)id <FlipViewDelegate> delegate;

+(InvoFlipViewController *)flipControllerWithArray:(NSArray *)array startIndex:(int)index;
@end
