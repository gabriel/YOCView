//
//  YOCViewController.m
//  YOCView
//
//  Created by Gabriel on 2/10/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOCViewController.h"

@interface YOCViewController ()
@property YOCView *contentView;
@end

// These need to match "protected" methods in YOCView
@interface YOCView (YOCViewController)
- (void)_viewDidLayoutSubviews;
- (void)_viewDidLoad;
- (void)_didBecomeActive;
- (void)_willResignActive;
@end

@implementation YOCViewController

- (id)initWithView:(YOCView *)view {
  if ((self = [super init])) {
    // If the view passed in is part of another view controller, lets nil it
    view.navigation.viewController.view = nil;

    _contentView = view;
    view.navigation = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
  }
  return self;
}

+ (YOCViewController *)viewControllerForView:(YOCView *)view {
  return [[YOCViewController alloc] initWithView:view];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)loadView {
  [super loadView];
  self.view = _contentView;
}

- (void)viewDidLayoutSubviews {
  [_contentView _viewDidLayoutSubviews];
}

- (void)_didBecomeActive:(NSNotification *)notification {
  [_contentView _didBecomeActive];
}

- (void)_willResignActive:(NSNotification *)notification {
  [_contentView _willResignActive];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [_contentView viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [_contentView viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [_contentView viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [_contentView viewDidDisappear:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSAssert([NSThread isMainThread], @"Not on main thread");
  [_contentView _viewDidLoad];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  [_contentView setNeedsLayout];
}

- (UIViewController *)viewController {
  return self;
}

- (void)pushView:(YOCView *)contentView animated:(BOOL)animated {
  YOCViewController *viewController = [[YOCViewController alloc] initWithView:contentView];
  [self.navigationController pushViewController:viewController animated:animated];
}

//- (void)pushView:(YOCView *)contentView animation:(id<UIViewControllerAnimatedTransitioning>)animation {
//  YOCViewController *viewController = [[YOCViewController alloc] initWithView:contentView animation:animation];
//  self.navigationController.delegate = [GHUIViewTransitioning sharedTransitioning];
//  [self.navigationController pushViewController:viewController animated:YES];
//}

//- (void)presentView:(GHUIContentView *)contentView animation:(id<UIViewControllerAnimatedTransitioning>)animation completion:(void (^)(void))completion {
//  YOCViewController *viewController = [[YOCViewController alloc] initWithView:contentView animation:animation];
//  viewController.transitioningDelegate = [GHUIViewTransitioning sharedTransitioning];
//  viewController.modalPresentationStyle = UIModalPresentationCustom;
//  [self presentViewController:viewController animated:(!!animation) completion:completion];
//}

- (id<YONavigation>)presentView:(YOCView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
  view.viewOptions = view.viewOptions | YOCViewOptionsModal;
  YOCViewController *viewController = [[YOCViewController alloc] initWithView:view];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  [self presentViewController:navigationController animated:animated completion:completion];
  return viewController;
}

- (void)presentView:(YOCView *)view modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle completion:(void (^)(void))completion {
  YOCViewController *viewController = [[YOCViewController alloc] initWithView:view];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  navigationController.modalPresentationStyle = modalPresentationStyle;
  [self presentViewController:navigationController animated:YES completion:completion];
}

- (void)dismissViewAnimated:(BOOL)animated completion:(void (^)(void))completion {
  [self dismissViewControllerAnimated:animated completion:completion];
}

- (void)popViewAnimated:(BOOL)animated {
  [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewAnimated:(BOOL)animated {
  [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)swapView:(YOCView *)view animated:(BOOL)animated {
  NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
  [viewControllers removeLastObject];
  YOCViewController *viewController = [[YOCViewController alloc] initWithView:view];
  [viewControllers addObject:viewController];
  [self.navigationController setViewControllers:viewControllers animated:animated];
}

- (void)setViews:(NSArray *)views animated:(BOOL)animated {
  NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
  for (YOCView *view in views) {
    [viewControllers addObject:[[YOCViewController alloc] initWithView:view]];
  }

  [self.navigationController setViewControllers:viewControllers animated:animated];
}

@end

