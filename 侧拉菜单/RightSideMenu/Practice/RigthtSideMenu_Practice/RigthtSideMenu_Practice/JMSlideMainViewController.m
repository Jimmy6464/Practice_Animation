//
//  JMForstedMainViewController.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMSlideMainViewController.h"
#import "JMCommon.h"
#import "UIViewController+JMSlideMainViewController.h"
#import "UIView+JMFrostedViewController.h"
#import "UIImage+JMFrostedViewController.h"
#import "JMSlideContainerViewController.h"
@interface JMSlideMainViewController ()
@property (nonatomic, assign) CGFloat imageViewWidth;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, strong, readwrite) JMSlideContainerViewController *containerViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) BOOL  automaticSize;
@property (nonatomic, assign) CGSize calculateMenuViewSize;//decide the size of menuview
@end

@implementation JMSlideMainViewController
#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}
- (void)initializeSubviews
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprcated-declarations"
    self.wantsFullScreenLayout = YES;
#pragma clang diagnostic pop
    _panGestureEnabled = YES;
    _animationDuration = 0.40f;
    _backgroudFadeAmount = 0.3f;
    _blurTintColor = JMUIKitIsFlatMode() ? nil : [UIColor colorWithWhite:1 alpha:0.75f];
    _blurSaturationDeltaFactor =  1.8f;
    _containerViewController.slideViewController = self;
    _menuViewSize = CGSizeZero;
    _liveBlur = JMUIKitIsFlatMode();
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:_containerViewController action:@selector(panGestureRecognized:)];
    _automaticSize = YES;
    
}
+ (instancetype)slideMainWithContentViewController:(UIViewController *)contentViewController andMenuViewController:(UIViewController *)menuViewController
{
    JMSlideMainViewController *forsted = [[JMSlideMainViewController alloc]initWithContentViewController:contentViewController andMenuViewController:menuViewController];
    return forsted;
}
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController andMenuViewController:(UIViewController *)menuViewController
{
    self = [super init];
    if (self) {
        _contentViewController = contentViewController;
        _menuViewController = menuViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self re_displayController:self.contentViewController frame:self.view.bounds];
}
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.contentViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden
{
    return self.contentViewController;
}

#pragma mark - Setters
- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (_contentViewController) {
        _contentViewController = contentViewController;
        return;
    }
    
    [_contentViewController removeFromParentViewController];
    [_contentViewController.view removeFromSuperview];
    
    if (contentViewController) {
        [self addChildViewController:contentViewController];
        contentViewController.view.frame = self.containerViewController.view.frame;
        [self.view insertSubview:contentViewController.view atIndex:0];
        [contentViewController didMoveToParentViewController:self];
    }
    _contentViewController = contentViewController;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }

}
- (void)setMenuViewController:(UIViewController *)menuViewController
{
    if (_menuViewController) {
        [_menuViewController.view removeFromSuperview];
        [_menuViewController removeFromParentViewController];
    }
    _menuViewController  = menuViewController;
    
    CGRect frame = _menuViewController.view.frame;
    [_menuViewController willMoveToParentViewController:nil];
    [_menuViewController removeFromParentViewController];
    [_menuViewController.view removeFromSuperview];
    _menuViewController = menuViewController;
    if (!_menuViewController) {
        return;
    }
    [self.containerViewController addChildViewController:menuViewController];
    menuViewController.view.frame = frame;
    [self.containerViewController.containerView addSubview:menuViewController.view];
    [menuViewController didMoveToParentViewController:self];
}
- (void)setMenuViewSize:(CGSize)menuViewSize
{
    _menuViewSize = menuViewSize;
    self.automaticSize = NO;
}

#pragma mark  - public methods
- (void)presentMenuViewController
{

}
- (void)presentMenuViewControllerWithAnimatedApperance:(BOOL)animateApperance
{
    if ([self.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)]&& [self.delegate respondsToSelector:@selector(frostedViewConfroller:willShowMenuViewController:)]) {
        [self.delegate frostedViewConfroller:self willShowMenuViewController:self.menuViewController];
    }
    
    self.containerViewController.animateApperance = animateApperance;
    if (self.automaticSize) {
        if (self.direction == FrostedViewConrtollerDirectionLeft || self.direction == FrostedViewConrtollerDirectionRight) {
            self.calculateMenuViewSize = CGSizeMake(self.contentViewController.view.frame.size.width - 50.0f, self.contentViewController.view.frame.size.height);
        }
        if (self.direction == FrostedViewConrtollerDirectionTop || self.direction == FrostedViewConrtollerDirectionBottom) {
            self.calculateMenuViewSize = CGSizeMake(self.contentViewController.view.frame.size.width, self.contentViewController.view.frame.size.height - 50.0f);
        }
    }else {
        self.calculateMenuViewSize = CGSizeMake(_menuViewSize.width>0 ?_menuViewSize.width:self.contentViewController.view.frame.size.width, _menuViewSize.height>0 ? _menuViewSize.height:self.contentViewController.view.frame.size.height);
    }
    
    if (!self.liveBlur) {
        if (JMUIKitIsFlatMode() && !self.blurTintColor) {
            self.blurTintColor = [UIColor colorWithWhite:1.0 alpha:0.75f];
        }
        //get the screeshot
        self.containerViewController.screenshotImage = [[self.contentViewController.view re_screenshot] re_applyBlurWithRadius:self.blurRadius tintColor:self.blurTintColor saturationDeltaFactor:self.blurSaturationDeltaFactor maskImage:nil];
    }
    [self re_displayController:self.containerViewController frame:self.contentViewController.view.frame];
    self.visible = YES;
}

- (void)hideMenuViewControllerWithCompletionHandler:(void (^)(void))completionHandler
{
    if (!self.visible) {//when call hide menu before menuViewController added to containerViewController, the menuViewController will never added to contaierViewController
        return;
    }
    
    if (!self.liveBlur) {
        self.containerViewController.screenshotImage = [[self.contentViewController.view re_screenshot] re_applyBlurWithRadius:self.blurRadius tintColor:self.blurTintColor saturationDeltaFactor:self.blurSaturationDeltaFactor maskImage:nil];
        [self.containerViewController refreshBackgroundImage];
    }
    [self.containerViewController hideWithWithCompletionHandler:completionHandler];
}

- (void)resizeMenuViewControllerToSize:(CGSize)size
{
    if (!self.liveBlur) {
        self.containerViewController.screenshotImage = [[self.contentViewController.view re_screenshot] re_applyBlurWithRadius:self.blurRadius tintColor:self.blurTintColor saturationDeltaFactor:self.blurSaturationDeltaFactor maskImage:nil];
        [self.containerViewController refreshBackgroundImage];
    }
    [self.containerViewController resizeToSize:size];
}
- (void)hideMenuViewController
{
    [self hideMenuViewControllerWithCompletionHandler:nil];
}
//called panGesture method
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    if ([self.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self.delegate respondsToSelector:@selector(frostedViewConfroller:didRecognizePanGesture:)]) {
        [self.delegate frostedViewConfroller:self didRecognizePanGesture:recognizer];
    }
    
    if (!self.panGestureEnabled) {
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self presentMenuViewControllerWithAnimatedApperance:NO];
    }
    
    [self.containerViewController panGestureRecognized:recognizer];
}
#pragma mark - Rotation handler
- (BOOL)shouldAutorotate
{
    return self.contentViewController.shouldAutorotate;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if ([self.delegate conformsToProtocol:@protocol(JMSlideMainViewControllerDelgate)] && [self respondsToSelector:@selector(frostedViewConfroller:willAnimateRotationToInterfaceOrientation:duration:)]) {
        [self.delegate frostedViewConfroller:self willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    
    if (self.visible) {
        if (self.automaticSize) {
            if (self.direction == FrostedViewConrtollerDirectionLeft || self.direction == FrostedViewConrtollerDirectionRight) {
                self.calculateMenuViewSize = CGSizeMake(self.view.bounds.size.width - 50.0f, self.view.bounds.size.height);
            }
        }
        if (self.direction == FrostedViewConrtollerDirectionTop || self.direction == FrostedViewConrtollerDirectionBottom) {
            self.calculateMenuViewSize = CGSizeMake(self.contentViewController.view.frame.size.width, self.contentViewController.view.frame.size.height - 50.0f);
        }

    }else {
        self.calculateMenuViewSize = CGSizeMake(_menuViewSize.width>0 ?_menuViewSize.width:self.contentViewController.view.frame.size.width, _menuViewSize.height>0 ? _menuViewSize.height:self.contentViewController.view.frame.size.height);
    }
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (!self.visible) {
        self.calculateMenuViewSize = CGSizeZero;
    }
}
@end
