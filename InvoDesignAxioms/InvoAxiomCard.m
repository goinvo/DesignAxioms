//
//  InvoAxiomCard.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

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
