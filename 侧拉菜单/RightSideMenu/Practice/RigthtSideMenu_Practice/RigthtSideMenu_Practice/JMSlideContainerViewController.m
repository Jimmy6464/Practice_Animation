//
//  JMSlideContainerViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMSlideContainerViewController.h"

@interface JMSlideContainerViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSMutableArray *backgroundViews;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGPoint containerOrigin;
@end
@implementation JMSlideContainerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundViews = [NSMutableArray new];
    for (NSInteger i = 0; i<4; i++) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectNull];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.0f;
        [self.view addSubview:backgroundView];
        [self.backgroundViews addObject:backgroundView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
        [backgroundView addGestureRecognizer:tap];
    }
    
    self.containerView = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.containerView.clipsToBounds = YES;
    
}
- (void)tapGestureRecognized:(UITapGestureRecognizer *)tap
{

}
- (void)refreshBackgroundImage
{
    
}
@end
