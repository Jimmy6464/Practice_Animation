//
//  JMCommon.m
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "JMCommon.h"
#import <UIKit/UIKit.h>

BOOL JMFrostedViewControllerUIKitIsFlatMode(void)
{
    static BOOL isUIKitFlatMode = NO;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        if (floor(NSFoundationVersionNumber) > 993.0) {
            //If your app is running in leagacy mode, tintColor will be nil - else it must be set to some color
            if ([UIApplication sharedApplication].keyWindow) {
                isUIKitFlatMode = [[UIApplication sharedApplication].delegate.window respondsToSelector:@selector(tintColor)];
            }else {
                //Possible that we're called early on (e.g. when used in a Storyboard).Adapt and use a temporary window.
                isUIKitFlatMode = [[UIWindow new] respondsToSelector:@selector(tintColor)];
            }
        }
    });
    return isUIKitFlatMode;
}
