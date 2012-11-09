//
//  InvoCardDetailViewController.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import "InvoCardDetailViewController.h"

#import "Constants.h"

#import "ImageFromRect.h"

@interface InvoCardDetailViewController ()
{
    int scrollNum;
    BOOL isGesture;
}

@property (nonatomic, strong) NSArray *bigImages;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *startImage;

-(id)initWithArray:(NSArray *)array startIndex:(int)index  nib:(NSString *)nibName;
-(void)initGestureRecognizers;

-(NSString *)currentImageName;

-(void)fillScrollView;
-(void)putBackCurrCardWithAnimation;
@end

@implementation InvoCardDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
//    NSLog(@"view will appear");
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // [self.view setBackgroundColor:[UIColor colorWithRed:1.0f green:0.89f blue:0.70f alpha:1.00f]];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.00f]];
    [self initGestureRecognizers];
    isGesture = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}


+(InvoCardDetailViewController *)detailViewWithArray:(NSArray *)array startIndex:(int)index{

    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone) {
        
        return [[self alloc] initWithArray:[array copy] startIndex:(int)index nib:@"InvoCardDetailViewController_iPhone"];
    }
    else
    return [[self alloc] initWithArray:[array copy] startIndex:(int)index nib:@"InvoCardDetailViewController_iPad"];
}


-(id)initWithArray:(NSArray *)array startIndex:(int)index nib:(NSString *)nibName{


    self = [super initWithNibName:nibName bundle:nil];
    
    if (self) {
        
        
        self.bigImages = [array copy];
                
        float padding = (SCREEN_HEIGHT - DETAIL_SCROLL_HEIGHT)/2;
        
        padding = (padding >0)? padding-10 :0;
       // padding = padding-10;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,padding, DETAIL_SCROLL_WIDTH, DETAIL_SCROLL_HEIGHT)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = YES;
        self.scrollView.directionalLockEnabled = YES;
      
        [self.view addSubview:self.scrollView];
        
        [self fillScrollView];

        [self.scrollView setContentOffset:CGPointMake(DETAIL_SCROLL_WIDTH*(index+1), 0) animated:NO];
        
        self.startImage = [self currentImageName];
        
        scrollNum = 0;
    }
    return self;
}


#pragma mark -
-(void)fillScrollView{

    int count = [self.bigImages count];
    
    [self.scrollView setContentSize:CGSizeMake((DETAIL_SCROLL_WIDTH) *(count+2), DETAIL_SCROLL_HEIGHT)];
    
    for (int i=0; i<count;i++) {
        
        NSString *imageName = [self.bigImages objectAtIndex:i];
        
        CGRect imageRect =   CGRectMake((i+1)*DETAIL_SCROLL_WIDTH, 0, DETAIL_SCROLL_WIDTH, DETAIL_SCROLL_HEIGHT);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        [imageView setImage:[UIImage imageNamed:imageName]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.scrollView addSubview:imageView];
    }
    
    //Adding the first image as the last image to enable circular scrolling
    {
        
        CGRect imageRect =   CGRectMake(DETAIL_SCROLL_WIDTH *count+DETAIL_SCROLL_WIDTH, 0, DETAIL_SCROLL_WIDTH, DETAIL_SCROLL_HEIGHT);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:[UIImage imageNamed:[self.bigImages objectAtIndex:0 ]]];
        [self.scrollView addSubview:imageView];
    }
    //Adding the last image as the first image to enable circular scrolling
    {
        
        CGRect imageRect =   CGRectMake(0, 0, DETAIL_SCROLL_WIDTH, DETAIL_SCROLL_HEIGHT);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:[UIImage imageNamed:[self.bigImages objectAtIndex:count-1 ]]];
        [self.scrollView addSubview:imageView];
    }
    
}

-(NSString *)currentImageName{

    float scrollCUrrX = [self.scrollView contentOffset].x;
    
    scrollCUrrX = scrollCUrrX/DETAIL_SCROLL_WIDTH;
    
    scrollCUrrX = scrollCUrrX-1;
    
    NSString *flipImageName = [self.bigImages objectAtIndex:scrollCUrrX] ;
    
    return [flipImageName copy];
}


-(void)initGestureRecognizers{

    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapReco.numberOfTouchesRequired = 1;
    tapReco.numberOfTapsRequired = 1;
    tapReco.delegate = self;
    [self.view addGestureRecognizer:tapReco];
    
    UITapGestureRecognizer *doubleTapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTapReco.numberOfTouchesRequired = 1;
    doubleTapReco.numberOfTapsRequired = 2;
    doubleTapReco.delegate = self;
    [self.view addGestureRecognizer:doubleTapReco];
    
    [tapReco requireGestureRecognizerToFail:doubleTapReco];
    
    UIPinchGestureRecognizer *pinchReco = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    pinchReco.delegate = self;
    [self.view addGestureRecognizer:pinchReco];
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if (isGesture) {
        return YES;
    }
    return NO;
}

#pragma mark Handle Gestures

-(void)handleTap:(UITapGestureRecognizer *)tapGesture{
    
    NSString *currimgName = [self currentImageName];

    InvoFlipViewController *flip = [InvoFlipViewController flipControllerWithArray:[self.bigImages copy] startIndex:[self.bigImages indexOfObject:currimgName]];
    [flip setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    flip.delegate = self;
    [self presentViewController:flip animated:YES completion:nil];
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch{

    if (pinch.state == UIGestureRecognizerStateBegan) {
        
        [self.delegate hideImg:[[self currentImageName] copy]];
    }
    
    else if (pinch.state ==UIGestureRecognizerStateChanged) {
        
        if (pinch.scale >=0.0 && pinch.scale <=1.0) {
            
            [self.scrollView  setTransform:CGAffineTransformMakeScale(pinch.scale, pinch.scale)];
            [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.0*pinch.scale]];
        }
        else{
            [self.scrollView  setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }
    }
    
    else if (pinch.state == UIGestureRecognizerStateEnded || pinch.state == UIGestureRecognizerStateCancelled) {
        
        if (pinch.scale <=0.8) {
            
            [self putBackCurrCardWithAnimation];
        }
        else{            
            [self.delegate unhideImg:[[self currentImageName] copy]];
            
            [UIView animateWithDuration:0.3f animations:^(){
            
                [self.scrollView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            }];
        }
    }
}

-(void)doubleTap:(UITapGestureRecognizer *)tapReco{

    [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:0.5f]];
    [self putBackCurrCardWithAnimation];
}

-(void)putBackCurrCardWithAnimation{

    isGesture = NO;
    
    CGPoint origPosition = [self.delegate getPositionOf:[self currentImageName]];
    
    float xScale = 0.2;
    float yScale = 0.2;
    CGPoint newPt = CGPointZero;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        xScale = SMALL_AXIOM_IPAD_WIDTH / 670.0;
        yScale = SMALL_AXIOM_IPAD_HEIGHT/ DETAIL_SCROLL_HEIGHT;
        
        newPt = CGPointMake(origPosition.x +SMALL_AXIOM_IPAD_WIDTH *0.5, origPosition.y +SMALL_AXIOM_IPAD_HEIGHT*0.5);
    }
    else{
        xScale = SMALL_AXIOM_IPHONE_WIDTH / DETAIL_SCROLL_WIDTH;
        yScale = SMALL_AXIOM_IPHONE_HEIGHT/ 480.0;
        
        newPt = CGPointMake(origPosition.x +SMALL_AXIOM_IPHONE_WIDTH *0.5, origPosition.y +SMALL_AXIOM_IPHONE_HEIGHT*0.5);
    }
    
    [UIView animateWithDuration:0.5 delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseOut animations:^(){
        
        [self.scrollView setCenter:newPt];
        [self.scrollView setScrollEnabled:NO];
        [self.scrollView setTransform:CGAffineTransformMakeScale(xScale, yScale)];
    } completion:^(BOOL finished){
        if(finished){
            
            [self.delegate mainScrollviewYOffset:origPosition];
            [self.scrollView removeFromSuperview];
            [self.delegate unhideImg:[self currentImageName]];
            [self.presentingViewController dismissViewControllerAnimated:NO completion:^(){
            
                [self.delegate enableParentTouches];
            }];
        }
    }];

}

#pragma mark -
#pragma mark scrollView Delegate-
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    (scrollNum ==0)?[self.delegate unhideImg:[self.startImage copy]]:nil;
    scrollNum ++;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    // The key is repositioning without animation
    if (self.scrollView.contentOffset.x == 0) {
     
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - DETAIL_SCROLL_WIDTH*2,0,DETAIL_SCROLL_WIDTH,DETAIL_SCROLL_HEIGHT) animated:NO];
    }
     if (self.scrollView.contentOffset.x == self.scrollView.contentSize.width-DETAIL_SCROLL_WIDTH) {
     
        [self.scrollView scrollRectToVisible:CGRectMake(DETAIL_SCROLL_WIDTH,0,DETAIL_SCROLL_WIDTH,DETAIL_SCROLL_HEIGHT) animated:NO];
    }
    
 //   NSLog(@"Scroll View content offset is %@", NSStringFromCGPoint(self.scrollView.contentOffset));
}

#pragma mark -

#pragma mark Delegate From other classes
-(void)dismiss{

    [self putBackCurrCardWithAnimation];
}

-(void)setSccrollFrame:(CGPoint)offset scaleXY:(float)scale{

    [self.scrollView setTransform:CGAffineTransformMakeScale(scale, scale)];
    [self.scrollView setCenter:CGPointMake(offset.x, offset.y)];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:0.0f]];
}

-(void)setContentOffset:(CGPoint)newOffset{

    [self.scrollView setContentOffset:newOffset];
}

-(void)askParentToHide:(NSString *)img{

    [self.delegate hideImg:img];
}

-(void)askParentToUnHide:(NSString *)img{

    [self.delegate unhideImg:img];
}

#pragma mark -

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end
