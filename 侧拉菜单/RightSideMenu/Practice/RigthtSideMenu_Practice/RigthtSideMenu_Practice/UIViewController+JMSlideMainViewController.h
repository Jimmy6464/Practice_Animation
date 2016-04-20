//
//  UIViewController+JMSlideMainViewController.h
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMSlideMainViewController;
@interface UIViewController (JMSlideMainViewController)
@property (nonatomic, strong, readonly) JMSlideMainViewController *slideViewController;
- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame;
- (void)re_hideController:(UIViewController *)controller;
@end
