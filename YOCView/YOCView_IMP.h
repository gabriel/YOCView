//
//  YOCView.h
//  YOViewController
//
//  Created by Gabriel on 2/2/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import <YOLayout/YOLayout.h>
#import <YOLayout/YOBox.h>

#import "YONavigation.h"

@class YOCViewController;

typedef NS_ENUM (NSUInteger, YOCViewOptions) {
  YOCViewOptionsNone = 0,
  YOCViewOptionsModal = 1 << 0,
  YOCViewOptionsHideNavigation = 1 << 1,
};

@interface YOCView : YOView

@property (weak) id<YONavigation> navigation;
@property (nonatomic) NSString *navigationTitle;
@property (nonatomic) NSString *navigationBackTitle;
@property YOCViewOptions viewOptions;
@property (readonly, getter=isVisible) BOOL visible;

- (YOCViewController *)setViewControllerOnWindow:(UIWindow *)window;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

- (void)viewDidBecomeActive;
- (void)viewWillResign;

- (void)viewDidLayoutSubviews;
- (void)viewDidLoad;
- (void)viewDidLoadWithLayout;

- (void)viewWillAppearAfterLoad:(BOOL)animated;
- (void)viewDidAppearAfterLoad:(BOOL)animated;

/*!
 Get top layout guide (from view controller).
 */
- (id<UILayoutSupport>)topLayoutGuide;

@end
