//
//  InvoAxiomCard.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.

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

@protocol InvoAxiomCardDeleate <NSObject>

@optional
-(void)handleCardTapWithCard:(NSString *)card;

@end

@interface InvoAxiomCard : UIView

@property (nonatomic, assign)id <InvoAxiomCardDeleate> delegate;

@property (nonatomic, strong)NSString *cardName;


+(InvoAxiomCard *)axiomCardWithFrame:(CGRect)frame imageName:(NSString *)imgName;
@end
