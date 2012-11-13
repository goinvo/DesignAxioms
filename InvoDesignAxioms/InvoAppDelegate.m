//
//  InvoAppDelegate.m
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


#import "InvoAppDelegate.h"

#import "InvoFirstViewController.h"

#import "InvoNavigationController.h"

@implementation InvoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIViewController *viewController1;
    
    if ([[UIScreen mainScreen]bounds].size.height ==568) {
        viewController1 = [[InvoFirstViewController alloc] initWithNibName:@"FirstViewIphone5" bundle:nil];
    }
    else{
    
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    viewController1 = [[InvoFirstViewController alloc] initWithNibName:@"InvoFirstViewController_iPad" bundle:nil];
        }
        else{
            viewController1 = [[InvoFirstViewController alloc] initWithNibName:@"InvoFirstViewController_iPhone" bundle:nil];
        }
    }
    /*
    self.navigationCtrl = [[UINavigationController alloc]initWithRootViewController:viewController1];
    [self.navigationCtrl setHidesBottomBarWhenPushed:YES];
    [self.navigationCtrl setWantsFullScreenLayout:YES];
    self.navigationCtrl.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.navigationCtrl.toolbarHidden = YES;

     */
    self.navigationCtrl = [[InvoNavigationController alloc] initWithRootViewController:viewController1];
    
    
    [self.window setRootViewController:self.navigationCtrl];
    [self.window makeKeyAndVisible];
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    if ([url isEqual:[NSURL URLWithString:@"bandu://"]]) {
//        
//        if ([sourceApplication isEqualToString:@"com.insurgentgames.skeletonkey"]|| [sourceApplication isEqualToString:@"com.poplobby.ch"]) {
//            
//            if (self.isGamePlaying) {
//                
//                NSLog(@"skeleton key was played before the app went into background");
//                NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:@"game",@"alertType",[url copy],@"gameUrl", nil];
//                NSNotification *notification = [NSNotification notificationWithName:@"AlertEnd" object:nil userInfo:userData];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                
//            }
//        }
//    }
//    
//    NSLog(@"url to open %@",[url description]);
//    NSLog(@"source application is %@",[sourceApplication description]);
//    NSLog(@"annotation %@",[annotation description]);
//    return YES;
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
