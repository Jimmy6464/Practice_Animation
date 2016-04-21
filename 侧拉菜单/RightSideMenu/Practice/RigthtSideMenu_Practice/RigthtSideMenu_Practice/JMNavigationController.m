//
//  JMNavigationController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMNavigationController.h"
#import "JMMenuViewContorller.h"
#import "UIViewController+JMSlideMainViewController.h"
@interface JMNavigationController ()
@property (nonatomic, strong) JMMenuViewContorller *menuVC;
@end
@implementation JMNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}
- (void)showMenu
{
    //Dismiss keyboard (optional)
    
    [self.view endEditing:YES];
    [self.slideViewController.view endEditing:YES];
    
    //present the view controller
    [self.slideViewController presentMenuViewController];
}
#pragma mark - Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    [self showMenu];
}
@end
