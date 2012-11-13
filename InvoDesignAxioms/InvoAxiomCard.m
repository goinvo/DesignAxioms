//
//  InvoAxiomCard.m
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


#import "InvoAxiomCard.h"

@interface InvoAxiomCard ()

@property (nonatomic, strong) UIImageView *imgView;
//@property (nonatomic, strong)NSString *cardName;

- (id)initWithFrame:(CGRect)frame image:(NSString *)imgName;

@end

@implementation InvoAxiomCard

+(InvoAxiomCard *)axiomCardWithFrame:(CGRect)frame imageName:(NSString *)imgName{

    return [[self alloc]initWithFrame:frame image:[imgName copy]];
}

- (id)initWithFrame:(CGRect)frame image:(NSString *)imgName
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setUserInteractionEnabled:YES];
        self.cardName = [imgName copy];
        UIImage *backImg = [UIImage imageNamed:imgName];
//        [self setContentMode:UIViewContentModeScaleAspectFill];
//        [self setBackgroundColor:[UIColor colorWithPatternImage:backImg]];
        // Initialization code
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.imgView setContentMode:UIViewContentModeScaleToFill];
        [self.imgView setImage:backImg];
        
        [self addSubview:self.imgView];
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

//    NSLog(@"touches ended for card %@",[self.cardName copy]);
    [self.delegate handleCardTapWithCard:[self.cardName copy]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
     
    UIImage *img = [UIImage imageNamed:self.cardName];
    [img drawInRect:rect];
}
*/

@end
