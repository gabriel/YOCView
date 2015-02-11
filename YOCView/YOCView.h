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

typedef NS_ENUM (NSUInteger, YOCViewPresentationMode) {
  YOCViewPresentationModeDefault = 0,
  YOCViewPresentationModeModal = 1 << 0,
  YOCViewPresentationModeHideNavigation = 1 << 1,
};

@protocol YONavigation <NSObject>
- (void)pushView:(YOView *)view animated:(BOOL)animated;
- (void)popViewAnimated:(BOOL)animated;
- (void)swapView:(YOView *)view animated:(BOOL)animated;
- (void)setViews:(NSArray *)views animated:(BOOL)animated;
- (void)popToRootViewAnimated:(BOOL)animated;
- (UINavigationItem *)navigationItem;
- (UIInterfaceOrientation)interfaceOrientation;
- (UIViewController *)viewController;

//- (void)pushView:(YOView *)view animation:(id<UIViewControllerAnimatedTransitioning>)animation;
//
//- (void)presentView:(YOView *)view animation:(id<UIViewControllerAnimatedTransitioning>)animation completion:(void (^)(void))completion;

- (void)presentView:(YOView *)view modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle completion:(void (^)(void))completion;

- (id<YONavigation>)presentView:(YOView *)contentView animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismissViewAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end


@interface YOCView : YOView

@property (weak) id<YONavigation> navigation;
@property (nonatomic) NSString *navigationTitle;
@property (nonatomic) NSString *navigationBackTitle;
@property YOCViewPresentationMode presentationMode;

+ (UIViewController *)viewControllerForView:(YOCView *)view;

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
