//
//  InvoAxiomCard.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvoAxiomCardDeleate <NSObject>

@optional
-(void)handleCardTapWithCard:(NSString *)card;

@end

@interface InvoAxiomCard : UIView

@property (nonatomic, assign)id <InvoAxiomCardDeleate> delegate;

@property (nonatomic, strong)NSString *cardName;


+(InvoAxiomCard *)axiomCardWithFrame:(CGRect)frame imageName:(NSString *)imgName;
@end
