//
//  YOCViewController.h
//  YOCView
//
//  Created by Gabriel on 2/10/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <YOLayout/YOLayout.h>

#import "YOCView.h"

@interface YOCViewController : UIViewController <YONavigation>

- (id)initWithView:(YOCView *)view;

@end
