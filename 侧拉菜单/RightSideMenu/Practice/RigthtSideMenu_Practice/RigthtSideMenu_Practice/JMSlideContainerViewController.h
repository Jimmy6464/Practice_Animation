//
//  JMSlideContainerViewController.h
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMSlideMainViewController;

@interface JMSlideContainerViewController : UIViewController
@property (nonatomic, strong) UIImage *screenshotImage;
@property (nonatomic, weak, readwrite) JMSlideContainerViewController *slideViewController;
@property (nonatomic, assign) BOOL animateApperance;
@property (nonatomic, strong, readonly) UIView *containerView;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;
- (void)hide;
- (void)refreshBackgroundImage;
- (void)resizeToSize:(CGSize)size;
- (void)hideWithWithCompletionHandler:(void (^)(void))completionHandler;

@end
