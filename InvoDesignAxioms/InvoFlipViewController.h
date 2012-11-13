//
//  InvoFlipViewController.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/22/12.

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
