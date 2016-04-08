//
//  ViewController.m
//  核心动画
//
//  Created by Jimmy on 16/4/8.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"FDSF");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
#warning 核心动画，只是一个假象，真实的大小是没有变化，如果想改变控件的大
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.delegate = self;
    //设置图层的“属性”来决定“动画类型”
    //bounds 图层的尺寸动画
    animation.keyPath = @"bounds";
    //设置bounds尺寸变化后的大小
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 150, 150)];
    
    //变成动画完的状态
    animation.removedOnCompletion = NO;//动画是否移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    //2.往控件的图层添加动画
    [self.imageView.layer addAnimation:animation forKey:nil];
}
#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.imageView.bounds = CGRectMake(0, 0, 150, 150);
}

@end
