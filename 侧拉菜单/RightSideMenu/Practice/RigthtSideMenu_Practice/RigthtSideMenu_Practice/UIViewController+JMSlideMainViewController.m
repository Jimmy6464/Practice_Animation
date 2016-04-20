//
//  UIViewController+JMSlideMainViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "UIViewController+JMSlideMainViewController.h"
#import "JMSlideMainViewController.h"
@implementation UIViewController (JMSlideMainViewController)
- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    controller.view.frame = frame;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}
- (void)re_hideController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

- (JMSlideMainViewController *)slideViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JMSlideMainViewController class]]) {
            return (JMSlideMainViewController *)iter;
        }else if (iter.parentViewController && iter.parentViewController != iter){
            iter = iter.parentViewController;
        }else {
            iter = nil;
        }
    }
    return nil;
}
@end
