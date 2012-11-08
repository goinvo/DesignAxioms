//
//  InvoAppDelegate.h
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/19/12.
//  Copyright (c) 2012 InvolutionStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InvoNavigationController;

@interface InvoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) InvoNavigationController *navigationCtrl;
//@property (nonatomic, strong) UINavigationController *navigationCtrl;


@end
