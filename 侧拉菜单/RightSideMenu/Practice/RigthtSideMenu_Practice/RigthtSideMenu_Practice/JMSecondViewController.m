//
//  JMSecondViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/21.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMSecondViewController.h"
#import "JMNavigationController.h"
#import "UIViewController+JMSlideMainViewController.h"
@interface JMSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSArray *dataSources;
@end
@implementation JMSecondViewController
- (NSArray *)dataSources
{
    if (_dataSources == nil) {
        _dataSources = @[@"row1",@"row1",@"row1",@"row1",@"row1",@"row1"];
    }
    return _dataSources;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Second";
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:(JMNavigationController *)self.navigationController action:@selector(showMenu)];
    [self initializedSubviews];
}
#pragma  mark - initialized subviews
- (void)initializedSubviews
{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [self.view addSubview:tabelView];
    _tableView = tabelView;
}

#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources ? self.dataSources.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self re_hideController:self];
//    [self.navigationController  pushViewController:[JMSecondViewController new] animated:YES];
}
@end
