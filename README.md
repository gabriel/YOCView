YOCView
=========

Why are there view controllers?

# Podfile

```ruby
pod "YOCView"
```

# Usage

Instead of making a view controller with a content view, just create your content view by subclassing YOCView.

This content view should subclass YOCView.

```objc
#import <YOCView/YOCView.h>

@interface MainView : YOCView
@end
```

In the app delegate its important to setup the root view controller using `YOCView#viewControllerForView`.

```objc
MainView *mainView = [[MainView alloc] init];
self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YOCView viewControllerForView:mainView]];
```

Then in your main view you can push, pop, present, dismiss without worrying about view controllers.

```objc
@implementation MyView

- (void)someAction {
  MyView *view = [[MyView alloc] init];
  [self.navigation pushView:view animated:YES];
}

- (void)someActionForModal {
  MyView *view = [[MyView alloc] init];
  [self.navigation presentView:view animated:YES];
}

@end
```

# View Notifications

YOCView has the following notifications:

```objc
// Same as UIViewController notifications
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (void)viewDidLoad;

// When your app becomes active and this view is shown (after resigning the app)
- (void)viewDidBecomeActive;
- (void)viewWillResign;

// Same as viewDidLoad but after its been layout'ed.
- (void)viewDidLoadWithLayout;

// View will appear but only ever called once (after load)
- (void)viewWillAppearAfterLoad:(BOOL)animated;

// View did appear but only ever called once (after load)
- (void)viewDidAppearAfterLoad:(BOOL)animated;
```

# FAQ

## What if I need to access the view's controller?

`self.viewController` will return the view controller it's contained in.

## Why does YOCView subclass YOView?

This allows support for (YOLayout)[https://github.com/YOLayout/YOLayout]. But you don't have to use it if you don't want. YOLayout doesn't override anything so you can pretend it's just like a UIView.

# Example Project

The best way to follow and learn YOCView is by seeing it in action. Open the example project: [Example](https://github.com/YOCView/YOCView/tree/master/Example). 
