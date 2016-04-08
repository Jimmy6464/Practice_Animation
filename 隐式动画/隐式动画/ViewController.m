//
//  ViewController.m
//  隐式动画
//
//  Created by Jimmy on 16/4/8.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) CALayer *layerview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CALayer *layer = [CALayer new];
    //设置内容
    layer.contents = (id)[UIImage imageNamed:@"lufy"].CGImage;
    //设置大小
    layer.bounds = CGRectMake(0, 0, 100, 100);
    //设置位置
    layer.position = CGPointMake(300, 150);
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self.view.layer addSublayer:layer];
    self.layerview = layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //隐式动画,只有非根层才有隐式动画
    self.imageView.layer.bounds = CGRectMake(0, 0, 150, 150);
    self.layerview.bounds = CGRectMake(0, 0, 150, 150);

    //设置动画事务（CATransaction）
    [CATransaction begin];

    [CATransaction setAnimationDuration:5];
    self.layerview.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 1);
    self.layerview.bounds = CGRectMake(0, 0, 150, 150);
    [CATransaction commit];
}
@end
