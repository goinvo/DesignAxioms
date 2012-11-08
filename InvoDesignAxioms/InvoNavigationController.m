//
//  InvoNavigationController.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 11/5/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import "InvoNavigationController.h"

@implementation InvoNavigationController

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        NSLog(@"I work!");
        [self setHidesBottomBarWhenPushed:YES];
        [self setWantsFullScreenLayout:YES];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.toolbarHidden = YES;

    }
    
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end
