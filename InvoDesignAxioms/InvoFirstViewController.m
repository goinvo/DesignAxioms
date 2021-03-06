//
//  InvoFirstViewController.m
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


#import "InvoFirstViewController.h"

#import "InvoAboutViewController.h"
#import "Constants.h"

@interface InvoFirstViewController ()

@property (nonatomic, strong)InvoAssetsScrollView *assetsScrollView;

-(void)disableInteraction;
-(void)enableInteraction;
@end

@implementation InvoFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
        self.assetsScrollView = [InvoAssetsScrollView scrollViewWithFrame:self.view.bounds  
                                                       NumberOfComponents:5
                                                                     type:TYPE_AXIOMS];
        self.assetsScrollView.delegate = self;
        [self.view addSubview:self.assetsScrollView];
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setToolbarHidden:YES];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self.view setBackgroundColor:[UIColor colorWithRed:1.00f green:0.89f blue:0.70f alpha:1.00f]];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.00f]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark InvoAssetsScrollView

-(void)handleAssetTap:(NSString *)assetName{

    [self.assetsScrollView hideImage:assetName];
    
    InvoCardDetailViewController *detailVC = [InvoCardDetailViewController detailViewWithArray:[[self.assetsScrollView valuesArray] copy]
                                                                                    startIndex:[self.assetsScrollView
                                                                                 indexOfObject:[assetName copy]]];
    detailVC.delegate = self;
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    
    [self presentViewController:detailVC animated:NO completion:^(){
    
        [self disableInteraction];
    }];
    
}

-(void)handleAboutTap{

    InvoAboutViewController *abtVC = [[InvoAboutViewController alloc]initWithNibName:nil bundle:nil];
    abtVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:abtVC animated:YES completion:nil];
}
#pragma mark -

#pragma mark get Position fo currImage

-(CGPoint)getPositionOf:(NSString *)imageName{

    return [self.assetsScrollView getPositionOf:[imageName copy]];
}

#pragma mark -

-(void)hideImg:(NSString *)imageName{

    [self.assetsScrollView hideImage:imageName];
}

-(void)unhideImg:(NSString *)imageName{

    [self.assetsScrollView unhideImage:imageName];
}

-(void)mainScrollviewYOffset:(CGPoint)newPt{

    [self.assetsScrollView  scrollToYOffset:newPt];
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

-(void)disableInteraction{

    [self.assetsScrollView stopTouches];
}
-(void)enableInteraction{

    [self.assetsScrollView resumeTouches];
}

-(void)enableParentTouches{

    [self enableInteraction];
}
@end
