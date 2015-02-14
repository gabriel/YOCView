//
//  YOCView.m
//  YOViewController
//
//  Created by Gabriel on 2/2/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOCView_IMP.h"

#import "YOCViewController.h"

@interface YOCView ()
@property BOOL resignedActive;
@property BOOL visible;
@property BOOL didLoadWithLayout;
@property BOOL willAppear;
@property BOOL hasAppeared;
@end

@implementation YOCView

- (YOCViewController *)setViewControllerOnWindow:(UIWindow *)window {
  YOCViewController *viewController = [YOCViewController viewControllerForView:self];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  window.rootViewController = navigationController;
  return viewController;
}

- (id<UILayoutSupport>)topLayoutGuide {
  return self.navigation.viewController.topLayoutGuide;
}

- (void)setNavigationTitle:(NSString *)navigationTitle {
  _navigationTitle = navigationTitle;
  self.navigation.navigationItem.title = _navigationTitle;
}

- (void)setNavigationBackTitle:(NSString *)navigationBackTitle {
  _navigationBackTitle = navigationBackTitle;
  self.navigation.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_navigationBackTitle style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)_didBecomeActive {
  if (_resignedActive) {
    _resignedActive = NO;
    [self _viewWillAppear:NO activating:YES];
    [self viewDidAppear:NO];
    [self viewDidBecomeActive];
  }
}

- (void)_willResignActive {
  if (_visible) {
    _resignedActive = YES;
    [self viewWillResign];
    [self _viewWillDisappear:NO resigning:YES];
    [self viewDidDisappear:NO];
  }
}

- (void)_viewWillAppear:(BOOL)animated activating:(BOOL)activating {
  _visible = YES;

  if (!activating) {
    if (_navigationTitle) [self setNavigationTitle:_navigationTitle];
    if (_navigationBackTitle) [self setNavigationBackTitle:_navigationBackTitle];

    if ((_viewOptions & YOCViewOptionsModal) != 0) {
      UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(_dismiss)];
      self.navigation.navigationItem.leftBarButtonItem = closeItem;
    }

    if ((_viewOptions & YOCViewOptionsHideNavigation) != 0) {
      [self.navigation.viewController.navigationController setNavigationBarHidden:YES];
    } else {
      UINavigationController *navigationController = self.navigation.viewController.navigationController;
      if (navigationController.navigationBarHidden) {
        [navigationController setNavigationBarHidden:NO];
      }
    }
  }
}

- (void)_dismiss {
  [self.navigation dismissViewAnimated:YES completion:nil];
}

- (void)_viewWillDisappear:(BOOL)animated resigning:(BOOL)resigning {
  if (!resigning) {
    if ((_viewOptions & YOCViewOptionsHideNavigation) != 0) {
      [self.navigation.viewController.navigationController setNavigationBarHidden:NO animated:NO]; // No animated for a good reason (can't remember it tho)
    }
  }
  _visible = NO;
}

- (void)_viewDidDisappear:(BOOL)animated {
  [self viewDidDisappear:animated];
}

- (void)_viewDidLayoutSubviews {
  [self viewDidLayoutSubviews];
  if (!_didLoadWithLayout && (self.frame.size.width > 0 && self.frame.size.height > 0)) {
    _didLoadWithLayout = YES;
    [self viewDidLoadWithLayout];
  }
}

- (void)_viewDidLoad {
  [self viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  if (!_willAppear) {
    _willAppear = YES;
    [self viewWillAppearAfterLoad:animated];
  }
  [self _viewWillAppear:animated activating:NO];
}

- (void)viewDidAppear:(BOOL)animated {
  if (!_hasAppeared) {
    _hasAppeared = YES;
    [self viewDidAppearAfterLoad:animated];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [self _viewWillDisappear:animated resigning:NO];
}

- (void)viewDidDisappear:(BOOL)animated { }

- (void)viewDidLayoutSubviews { }
- (void)viewDidLoad { }
- (void)viewDidLoadWithLayout { }

- (void)viewDidBecomeActive { }
- (void)viewWillResign { }

- (void)viewWillAppearAfterLoad:(BOOL)animated { }
- (void)viewDidAppearAfterLoad:(BOOL)animated { }

@end