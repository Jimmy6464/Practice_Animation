//
//  JMCommon.h
//  RigthtSideMenu_Practice
//
//  Created by Jimmy on 16/4/18.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef JMUIKitIsFlatMode
#define JMUIKitIsFlatMode() JMFrostedViewControllerUIKitIsFlatMode()
#endif

BOOL JMFrostedViewControllerUIKitIsFlatMode(void);