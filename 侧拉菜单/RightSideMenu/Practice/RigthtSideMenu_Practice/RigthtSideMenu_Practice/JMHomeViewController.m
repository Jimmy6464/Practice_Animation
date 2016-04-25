//
//  JMHomeViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMNavigationController.h"
#import "UIViewController+JMSlideMainViewController.h"
#import "JMSecondViewController.h"
@implementation JMHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Home";
    self.view.backgroundColor = [ UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"menu"];
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 30, 25);
    [btn addTarget:(JMNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [ UIImage imageNamed:@"background"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    [self re_displayController:[JMSecondViewController new] frame:CGRectMake(100, 100, 200, 400)];
}
@end
