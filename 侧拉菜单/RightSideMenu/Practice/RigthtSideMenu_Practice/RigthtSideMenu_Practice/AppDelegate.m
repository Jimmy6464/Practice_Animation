//
//  AppDelegate.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "AppDelegate.h"
#import "JMNavigationController.h"
#import "JMHomeViewController.h"
#import "JMMenuViewContorller.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //create content and menu controller
    JMHomeViewController *home = [JMHomeViewController new];
    JMNavigationController *navigationVC = [[JMNavigationController alloc]initWithRootViewController:home];
    JMMenuViewContorller *menuVC = [JMMenuViewContorller new];
    
    //create slide view controller
    JMSlideMainViewController *slideVC = [JMSlideMainViewController slideMainWithContentViewController:navigationVC andMenuViewController:menuVC];
    slideVC.direction = FrostedViewConrtollerDirectionLeft ;
    slideVC.liveBlurBackgroundStyle = FrostedViewControllerLiveBackgroundStyleLight;
    slideVC.liveBlur = YES;
    slideVC.delegate = self;
    
    //make it a root controller
    self.window.rootViewController = slideVC;
    return YES;
}
#pragma mark - JMSlideMainViewControllerDelgate
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"panGesture");
}
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"will show menu");
}
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"did show menu");
}
-(void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"will hide menu");
}
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"did hide menu");
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
