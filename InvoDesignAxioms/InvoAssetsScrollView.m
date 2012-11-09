//
//  InvoAssetsScrollView.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import "InvoAssetsScrollView.h"
#import "Constants.h"

@interface InvoAssetsScrollView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, readwrite) BOOL isGestureEnabled;


- (id)initWithFrame:(CGRect)frame components:(int)componentNumber type:(NSString *)componentType;
-(void)addAxiomsToScrollView;

-(void)addAxiomsToScrollViewIpad;
@end

@implementation InvoAssetsScrollView


+(InvoAssetsScrollView *)scrollViewWithFrame:(CGRect)frame NumberOfComponents:(int)number type:(NSString *)type{

    return [[self alloc]initWithFrame:frame components:number type:[type copy]];
}

- (id)initWithFrame:(CGRect)frame components:(int)componentNumber type:(NSString *)componentType;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self resumeTouches];
                
        self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
//        self.scrollView.delegate = self;
        
        [self addSubview:self.scrollView];

        if ([componentType isEqualToString:TYPE_AXIOMS]) {
        
            self.itemsArray = [NSMutableArray array];
            
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                [self addAxiomsToScrollView];
            }
            else{
            
                [self addAxiomsToScrollViewIpad];
            }
//ADDING ABOUT BUTTON TO SCROLLVIEW
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, self.scrollView.contentSize.height -55, [UIScreen mainScreen].bounds.size.width-10, ABOUT_HEIGHT)];
            
            [btn.titleLabel setFont:[UIFont fontWithName:@"Kremlin" size:20]];
            [btn setTitle:@"ABOUT" forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:0.59f green:0.25f blue:0.19f alpha:1.00f]];
            
            [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];

        }
    }
    return self;
}

#pragma mark init scrollview for different devices
-(void)addAxiomsToScrollView{

    NSString *axiomsDictPath = [[NSBundle mainBundle]pathForResource:@"AxiomsList" ofType:@"plist"];
    
    NSDictionary *axiomsDict = [NSDictionary dictionaryWithContentsOfFile:axiomsDictPath];
    self.valuesArray = [axiomsDict allValues];
    int count = [self.valuesArray count];
    
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH,SMALL_AXIOM_IPHONE_HEIGHT * count/3 + PADDING * (2+count/3) + ABOUT_HEIGHT )];
    
    for (int i=0; i< count;i++) {
        
        int xoff = (i)%3;

        CGPoint offset = CGPointMake(PADDING + PADDING*xoff +xoff*SMALL_AXIOM_IPHONE_WIDTH, PADDING+ PADDING*(i/3) + (i/3)*SMALL_AXIOM_IPHONE_HEIGHT);
        
        InvoAxiomCard *card = [InvoAxiomCard axiomCardWithFrame:CGRectMake(offset.x, offset.y, SMALL_AXIOM_IPHONE_WIDTH, SMALL_AXIOM_IPHONE_HEIGHT)
                                                      imageName:[[self.valuesArray objectAtIndex:i]copy]];
        
        card.delegate = self;
        [self.scrollView addSubview:card];
        [self.itemsArray addObject:card];
    }
}

-(void)addAxiomsToScrollViewIpad{

    NSString *axiomsDictPath = [[NSBundle mainBundle]pathForResource:@"AxiomsList" ofType:@"plist"];
    
    NSDictionary *axiomsDict = [NSDictionary dictionaryWithContentsOfFile:axiomsDictPath];
    self.valuesArray = [axiomsDict allValues];
    int count = [self.valuesArray count];
    
//    NSLog(@"screen Width is %f", SCREEN_WIDTH);
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH,SMALL_AXIOM_IPAD_HEIGHT * count/3 + PADDING * (2+count/3) + ABOUT_HEIGHT )];
    
    for (int i=0; i< count;i++) {
        
        int xoff = (i)%3;
        
        CGPoint offset = CGPointMake(PADDING + PADDING*xoff +xoff*SMALL_AXIOM_IPAD_WIDTH, PADDING+ PADDING*(i/3) + (i/3)*SMALL_AXIOM_IPAD_HEIGHT);
        
        InvoAxiomCard *card = [InvoAxiomCard axiomCardWithFrame:CGRectMake(offset.x, offset.y, SMALL_AXIOM_IPAD_WIDTH, SMALL_AXIOM_IPAD_HEIGHT)
                                                      imageName:[[self.valuesArray objectAtIndex:i]copy]];
        card.delegate = self;
        [self.scrollView addSubview:card];
        
        [self.itemsArray addObject:card];
    }
}
#pragma mark -
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if (self.isGestureEnabled) {
        return YES;
    }
    return NO;
}

#pragma mark manage interactions
-(void)handleCardTapWithCard:(NSString *)card{

    [self.delegate handleAssetTap:[card copy]];
}

-(int)indexOfObject:(NSString *)objString{

  return ( [self.valuesArray indexOfObject:[objString copy]]);
}

-(void)btnTapped:(id)sender{

//    NSLog(@"About Tapped");
    [self.delegate handleAboutTap];
}

-(CGPoint)getPositionOf:(NSString *)imageName{

    int index = [self.valuesArray indexOfObject:imageName];
    
    int xoff = (index)%3;
    CGPoint position = CGPointZero;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        position = CGPointMake(PADDING + PADDING*xoff +xoff*SMALL_AXIOM_IPAD_WIDTH, PADDING+ PADDING*(index/3) + (index/3)*SMALL_AXIOM_IPAD_HEIGHT);
    }
    else{
        position = CGPointMake(PADDING + PADDING*xoff +xoff*SMALL_AXIOM_IPHONE_WIDTH, PADDING+ PADDING*(index/3) + (index/3)*SMALL_AXIOM_IPHONE_HEIGHT);
    }

    return [self.scrollView convertPoint:position toView:self.superview];
}

-(void)hideImage:(NSString *)img{

    for (InvoAxiomCard *card in self.scrollView.subviews) {
        
        if ([card.cardName isEqualToString:img]) {
        
            [card setHidden:YES];
            break;
        }
    }
}

-(void)unhideImage:(NSString *)img{

    for (InvoAxiomCard *card in self.itemsArray) {
        
        if ([card.cardName isEqualToString:img]) {
            
            [card setHidden:NO];
            break;
        }
    }
}

-(void)scrollToYOffset:(CGPoint)newPt{

    CGPoint convPt = [self.scrollView convertPoint:newPt fromView:self.superview];
//    NSLog(@"comvPt is %@", NSStringFromCGPoint(convPt));
    
//    NSLog(@"newY is %f",convPt.y);
//    NSLog(@"current offset is %@", NSStringFromCGPoint(self.scrollView.contentOffset));
    
    float maxHeight = 0.0;
    
    maxHeight = self.scrollView.contentSize.height - SCREEN_HEIGHT+20;
    
    float calY = (convPt.y/SCREEN_HEIGHT);

    calY = (SCREEN_HEIGHT*(calY)>maxHeight)? (maxHeight) :SCREEN_HEIGHT*(calY);
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x,calY) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)stopTouches{

    [self setUserInteractionEnabled:NO];
    self.isGestureEnabled = NO;
}

-(void)resumeTouches{
    
    [self setUserInteractionEnabled:YES];
    self.isGestureEnabled = YES;
    
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    NSLog(@"Scroll View content offset is %@", NSStringFromCGPoint(self.scrollView.contentOffset));
//    NSLog(@"Scroll content size is %@", NSStringFromCGSize(self.scrollView.contentSize));
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    NSLog(@"Scroll View content offset is %@", NSStringFromCGPoint(self.scrollView.contentOffset));
//}

@end
