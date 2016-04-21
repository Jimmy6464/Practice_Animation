//
//  JMSecondViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMSecondViewController.h"
#import "JMNavigationController.h"
@implementation JMSecondViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Second";
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:(JMNavigationController *)self.navigationController action:@selector(showMenu)];
}


@end
