//
//  JMHomeViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMNavigationController.h"
@implementation JMHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Home";
    self.view.backgroundColor = [ UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:(JMNavigationController *)self.navigationController action:@selector(showMenu)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [ UIImage imageNamed:@"background"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
}
@end
