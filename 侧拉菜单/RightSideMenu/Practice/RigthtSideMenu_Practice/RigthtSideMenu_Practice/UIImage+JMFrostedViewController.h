//
//  UIImage+JMFrostedViewController.h
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/19.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JMFrostedViewController)
- (UIImage *)re_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
