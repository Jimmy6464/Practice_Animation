//
//  JMForstedMainViewController.h
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FrostedViewConrtollerDirection) {
    FrostedViewConrtollerDirectionLeft,
    FrostedViewConrtollerDirectionRight,
    FrostedViewConrtollerDirectionTop,
    FrostedViewConrtollerDirectionBottom
};

typedef NS_ENUM(NSInteger, FrostedViewControllerLiveBackgroundStyle) {
    FrostedViewControllerLiveBackgroundStyleLight,
    FrostedViewControllerLiveBackgroundStyleDark
};
@class JMSlideMainViewController;
@protocol JMSlideMainViewControllerDelgate <NSObject>

@optional
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController willShowMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didShowMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController willHideMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewConfroller:(JMSlideMainViewController *)slideMainViewController didHideMenuViewController:(UIViewController *)menuViewController;
@end
@interface JMSlideMainViewController : UIViewController
@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, strong) UIViewController *menuViewController;
@property (nonatomic, strong,readonly) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) BOOL panGestureEnabled;
@property (nonatomic, assign) FrostedViewConrtollerDirection direction;
@property (nonatomic, assign, readwrite) CGSize calculateMenuViewSize;//decide the size of menuview
/*
 The backgrounFadeAmount is how much the background view fades when the menu view is presented
 1.0 is completely black.0.0 means the background does not dim at all
 The default value is 0.3.
 */
@property (nonatomic, assign) CGFloat backgroudFadeAmount;
@property (nonatomic, assign) UIColor *blurTintColor;// Used only when live blur is off
@property (nonatomic, assign) CGFloat blurRadius;// Used only when live blur is off
@property (nonatomic, assign) CGFloat blurSaturationDeltaFactor;// Used only when live blur is off(饱和度)
@property (nonatomic, assign) FrostedViewControllerLiveBackgroundStyle liveBlurBackgroundStyle;
@property (nonatomic, weak) id<JMSlideMainViewControllerDelgate> delegate;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL limitedMenuViewSize;
@property (nonatomic, assign) CGSize menuViewSize;
@property (nonatomic, assign) BOOL liveBlur;//iOS 7 only;


#pragma mark - public methods
//method to share the instance
+ (instancetype)slideMainWithContentViewController:(UIViewController *)contentViewController andMenuViewController:(UIViewController *)menuViewController;
//called method for presnting the MenuViewController
- (void)presentMenuViewController;
//called method when hidding the MenuViewCotorller
- (void)hideMenuViewController;
//resize the area of MenuViewController
- (void)resizeMenuViewControllerToSize:(CGSize)size;
//called method when hidding the MenuViewCotorller,block :after hidden the menuViewContorller;
- (void)hideMenuViewControllerWithCompletionHandler:(void(^)(void))completionHandler;
//called method when thouch in a panGesture
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;
@end
