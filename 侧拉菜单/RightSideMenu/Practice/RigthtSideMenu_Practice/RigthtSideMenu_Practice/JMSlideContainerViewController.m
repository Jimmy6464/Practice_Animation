//
//  JMSlideContainerViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMSlideContainerViewController.h"
#import "JMSlideMainViewController.h"
#import "UIViewController+JMSlideMainViewController.h"
@interface JMSlideContainerViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSMutableArray *backgroundViews;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGPoint containerOrigin;
@end

@interface JMSlideMainViewController ()

@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) CGSize calculatedMenuViewSize;
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
    [self.view addSubview:self.containerView];
    
    if (self.slideViewController.liveBlur) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toolbar.barStyle = (UIBarStyle)self.slideViewController.liveBlurBackgroundStyle;
        [self.containerView addSubview:toolbar];
    }else {
        [self addChildViewController:self.slideViewController.menuViewController];
        self.slideViewController.menuViewController.view.frame = self.containerView.bounds;
        [self.containerView addSubview:self.slideViewController.menuViewController.view];
        [self.slideViewController.menuViewController didMoveToParentViewController:self];
    }
    
    [self.view addGestureRecognizer:self.slideViewController.panGestureRecongnizer];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.slideViewController.visible) {
        self.backgroundImageView.image = self.screenshotImage;
        self.backgroundImageView.frame = self.view.bounds;
        self.slideViewController.menuViewController.view.frame = self.containerView.bounds;
        
        if (self.slideViewController.direction == FrostedViewConrtollerDirectionLeft) {
            [self setContainerFrame:CGRectMake(-self.view.frame.size.width, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
        }
        if (self.slideViewController.direction == FrostedViewConrtollerDirectionRight) {
            [self setContainerFrame:CGRectMake(self.view.frame.size.width, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.slideViewController.direction == FrostedViewConrtollerDirectionBottom) {
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.slideViewController.direction == FrostedViewConrtollerDirectionTop) {
            [self setContainerFrame:CGRectMake(0, self.slideViewController.calculatedMenuViewSize.height, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.animateApperance) {
            [self show];
        }
    }
}
- (void)setContainerFrame:(CGRect)frame
{
    UIView *leftBackgroundView = self.backgroundViews[0];
    UIView *topBackgroundView = self.backgroundViews[1];
    UIView *bottomBackgroundView = self.backgroundViews[2];
    UIView *rightBackgroundView = self.backgroundViews[3];
    
    leftBackgroundView.frame = CGRectMake(0, 0, frame.origin.x, self.view.frame.size.height);
    rightBackgroundView.frame = CGRectMake(frame.size.width + frame.origin.x, 0, self.view.frame.size.width - frame.size.width - frame.origin.x, self.view.frame.size.height);
    
    topBackgroundView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
    bottomBackgroundView.frame = CGRectMake(frame.origin.x, frame.size.height + frame.origin.y, frame.size.width, self.view.frame.size.height);
    
    self.containerView.frame = frame;
    self.backgroundImageView.frame = CGRectMake(-frame.origin.x, -frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
}
- (void)setBackgroundViewsAlpha:(CGFloat)alpha
{
    for (UIView *view in self.backgroundViews) {
        view.alpha = alpha;
    }
}
- (void)resizeToSize:(CGSize)size
{
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionLeft) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:nil];
        
    }
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionRight) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width - size.width, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:nil];

    }
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionTop) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:nil];

    }
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionLeft) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height - size.height, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:nil];

    }
}
- (void)show
{
    void (^completionHandler)(BOOL finished) = ^(BOOL finished){
        if ([self.slideViewController.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self.slideViewController.delegate respondsToSelector:@selector(frostedViewConfroller:didShowMenuViewController:)]) {
            [self.slideViewController.delegate frostedViewConfroller:self.slideViewController didShowMenuViewController:self.slideViewController.menuViewController];
        }
    };
    
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionLeft) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:completionHandler];
    }
    
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionRight) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width - self.slideViewController.calculatedMenuViewSize.width, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:completionHandler];
    }
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionTop) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:completionHandler];
    }
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionBottom) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height - self.slideViewController.calculatedMenuViewSize.height, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.slideViewController.backgroudFadeAmount];
        } completion:completionHandler];
    }
}
- (void)hide
{
    [self hideWithWithCompletionHandler:nil];
}
- (void)hideWithWithCompletionHandler:(void (^)(void))completionHandler
{
    void (^completionHandlerBlock)(void) =  ^{
        if ([self.slideViewController.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self.slideViewController.delegate respondsToSelector:@selector(frostedViewConfroller:didHideMenuViewController:)]) {
            [self.slideViewController.delegate frostedViewConfroller:self.slideViewController didHideMenuViewController:self.slideViewController.menuViewController];
        }
    };
    
    if ([self.slideViewController.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self.slideViewController.delegate respondsToSelector:@selector(frostedViewConfroller:willHideMenuViewController:)]) {
        [self.slideViewController.delegate frostedViewConfroller:self.slideViewController willHideMenuViewController:self.slideViewController.menuViewController];
    }
    
    //follow the direction
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionLeft) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(- self.slideViewController.calculatedMenuViewSize.width, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished){
            self.slideViewController.visible = NO;
            [self.slideViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionRight) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width, 0, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished){
            self.slideViewController.visible = NO;
            [self.slideViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionTop) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, -self.slideViewController.calculatedMenuViewSize.height, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished){
            self.slideViewController.visible = NO;
            [self.slideViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.slideViewController.direction == FrostedViewConrtollerDirectionBottom) {
        [UIView animateWithDuration:self.slideViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height, self.slideViewController.calculatedMenuViewSize.width, self.slideViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished){
            self.slideViewController.visible = NO;
            [self.slideViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
}
- (void)refreshBackgroundImage
{
    self.backgroundImageView.image = self.screenshotImage;
}

#pragma mark - Cesture recognizer
- (void)tapGestureRecognized:(UITapGestureRecognizer *)tap
{
    [self hide];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    if ([self.slideViewController.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self.slideViewController.delegate respondsToSelector:@selector(frostedViewConfroller:didRecognizePanGesture:)]) {
        [self.slideViewController.delegate  frostedViewConfroller:self.slideViewController didRecognizePanGesture:recognizer];
    }
    
    if (!self.slideViewController.panGestureEnabled) {
        return;
    }
    
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state ==  UIGestureRecognizerStateBegan) {
        self.containerOrigin = self.containerView.frame.origin;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.containerView.frame;
        switch (self.slideViewController.direction) {
            case FrostedViewConrtollerDirectionLeft:
                frame.origin.x = self.containerOrigin.x + point.x;
                if (frame.origin.x > 0) {
                    frame.origin.x = 0;
                    
                    if (!self.slideViewController.limitedMenuViewSize) {
                        frame.size.width = self.slideViewController.calculatedMenuViewSize.width + self.containerOrigin.x + point.x;
                        if (frame.size.width > self.view.frame.size.width) {
                            frame.size.width = self.view.frame.size.width;
                        }
                    }
                }
                break;
            case FrostedViewConrtollerDirectionRight:
                frame.origin.x = self.containerOrigin.x + point.x;
                if (frame.origin.x < self.view.frame.size.width - self.slideViewController.calculatedMenuViewSize.width ) {
                    frame.origin.x = self.view.frame.size.width - self.slideViewController.calculatedMenuViewSize.width;
                    
                    if (!self.slideViewController.limitedMenuViewSize) {
                        frame.origin.x = self.containerOrigin.x + point.x;
                        if (frame.origin.x < 0 ) {
                            frame.origin.x = 0;
                        }
                        frame.size.width = self.view.frame.size.width - frame.origin.x;
                    }
                }
                break;
            case FrostedViewConrtollerDirectionTop:
                
                break;
            case FrostedViewConrtollerDirectionBottom:
                
                break;
            default:
                break;
        }
        
    }
    
}
@end
