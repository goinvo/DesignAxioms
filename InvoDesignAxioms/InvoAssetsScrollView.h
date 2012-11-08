//
//  InvoAssetsScrollView.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoAxiomCard.h"


@protocol  InvoAssetScrollDeleate <NSObject>

@optional

-(void)handleAssetTap:(NSString *)assetName;
-(void)handleAboutTap;
@end

@interface InvoAssetsScrollView : UIView <InvoAxiomCardDeleate>

@property (nonatomic, strong)NSArray *valuesArray;

@property (nonatomic, assign)id <InvoAssetScrollDeleate> delegate;

+(InvoAssetsScrollView *)scrollViewWithFrame:(CGRect)frame NumberOfComponents:(int)number type:(NSString *)type;

-(int)indexOfObject:(NSString *)objString;

-(CGPoint)getPositionOf:(NSString *)imageName;

-(void)hideImage:(NSString *)img;
-(void)unhideImage:(NSString *)img;
-(void)scrollToYOffset:(float)newY;

-(void)stopTouches;
-(void)resumeTouches;
@end
