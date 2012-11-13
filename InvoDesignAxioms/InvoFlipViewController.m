//
//  InvoFlipViewController.m
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


#import "InvoFlipViewController.h"
#import "InvoCardDetailViewController.h"
#import "Constants.h"

@interface InvoFlipViewController ()


@property (nonatomic,readwrite)BOOL isPinch;


@property (nonatomic, strong) NSMutableArray *bigImages;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *startImage;

-(id)initWithArray:(NSArray *)array startIndex:(int)index  nib:(NSString *)nibName;

-(void)initAssetsWithArray:(NSArray *)arr;

@end

@implementation InvoFlipViewController


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
   
    [self.delegate setContentOffset:self.scrollView.contentOffset];
    
//    NSLog(@"self.view.frame is %@",NSStringFromCGPoint(self.scrollView.frame.origin));
    
    if(self.isPinch){
    
        CGPoint movePt = CGPointMake(self.scrollView.frame.origin.x + self.scrollView.frame.size.width*0.5, self.scrollView.frame.origin.y +self.scrollView.frame.size.height*0.5);
        
        [self.delegate setSccrollFrame:movePt scaleXY:self.scrollView.transform.a];
    }
    
//    NSLog(@"here here here");
}

+(InvoFlipViewController *)flipControllerWithArray:(NSArray *)array startIndex:(int)index{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return [[self alloc] initWithArray:[array copy] startIndex:index nib:@"InvoFlipViewController_iPad"];
    }
    else
        return [[self alloc] initWithArray:[array copy] startIndex:index nib:@"InvoFlipViewController_iPhone"];
}


-(id)initWithArray:(NSArray *)array startIndex:(int)index  nib:(NSString *)nibName{

    self = [super initWithNibName:nibName bundle:nil];
    
    if (self) {
        
        [self initAssetsWithArray:array];
        
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
        
        dispatch_async(dispatch_get_main_queue(), ^(){
        
            [self fillScrollView];
            
            [self.scrollView setContentOffset:CGPointMake(DETAIL_SCROLL_WIDTH*(index+1), 0) animated:NO];
            
            self.startImage = [self currentImageName];
        });
    }
    return self;
}

#pragma mark initializing the assets
-(void)initAssetsWithArray:(NSArray *)arr{
    
    NSArray *locArray = [arr copy];
    self.bigImages = [NSMutableArray array];
    
    for (int i=0;i<[locArray count]; i++) {
        
        NSString *currName = [locArray objectAtIndex:i];
        currName = [currName stringByReplacingOccurrencesOfString:@".png" withString:@"2.png"];
        
        [self.bigImages addObject:[currName copy]];
    }
}


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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.00f]];
    //[self.view setBackgroundColor:[UIColor colorWithRed:1.0f green:0.89f blue:0.70f alpha:1.00f]];
    
    dispatch_async(dispatch_get_current_queue(), ^(){

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
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    self.scrollView = nil;
    self.bigImages = nil;
    self.startImage = nil;
    
    [super viewDidUnload];
}

#pragma mark handling gestures
-(void)handleTap:(UITapGestureRecognizer *)tapGesture{

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch{
    
    if(pinch.state == UIGestureRecognizerStateBegan){
    
        NSString *currImageName = [self currentImageName];
        currImageName = [currImageName stringByReplacingOccurrencesOfString:@"2" withString:@""];
        [self.delegate askParentToHide:[currImageName copy]];
    }
    else if (pinch.state ==UIGestureRecognizerStateChanged) {
        
        if (pinch.scale >=0.0 && pinch.scale <=1.0) {
            [self.scrollView  setTransform:CGAffineTransformMakeScale(pinch.scale, pinch.scale)];
            [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.0*pinch.scale]];
        }
        else{
            NSString *currImageName = [self currentImageName];
            currImageName = [currImageName stringByReplacingOccurrencesOfString:@"2" withString:@""];
            [self.delegate askParentToUnHide:currImageName];
            
            [self.scrollView  setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }
    }
    
   else if (pinch.state == UIGestureRecognizerStateEnded) {
        
        if (pinch.scale <=0.8) {

            self.isPinch = YES;
            [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:0.0]];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){
                
                [self.delegate dismiss];
            }];
        }
        else{
            
            [UIView animateWithDuration:0.3f animations:^(){
                
                NSString *currImageName = [self currentImageName];
                currImageName = [currImageName stringByReplacingOccurrencesOfString:@"2" withString:@""];
                [self.delegate askParentToUnHide:currImageName];
                
                [self.scrollView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                
            }];
        }
    }
}

-(void)doubleTap:(UITapGestureRecognizer *)tapReco{
    
    self.isPinch = YES;
    
    NSString *currImageName = [self currentImageName];
    currImageName = [currImageName stringByReplacingOccurrencesOfString:@"2" withString:@""];
    [self.delegate askParentToHide:currImageName];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){
        
        [self.delegate dismiss];
    }];
}
#pragma mark -

#pragma mark scrollView Delegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    // The key is repositioning without animation
    if (self.scrollView.contentOffset.x == 0) {
        
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - DETAIL_SCROLL_WIDTH*2,0,DETAIL_SCROLL_WIDTH,DETAIL_SCROLL_HEIGHT) animated:NO];
    }
    if (self.scrollView.contentOffset.x == self.scrollView.contentSize.width-DETAIL_SCROLL_WIDTH) {
        
        [self.scrollView scrollRectToVisible:CGRectMake(DETAIL_SCROLL_WIDTH,0,DETAIL_SCROLL_WIDTH,DETAIL_SCROLL_HEIGHT) animated:NO];
    }
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
