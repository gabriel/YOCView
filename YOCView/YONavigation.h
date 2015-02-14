//
//  YONavigation.h
//  YOCView
//
//  Created by Gabriel on 2/14/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

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
