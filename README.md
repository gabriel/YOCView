YOCView
=========

YOCView helps you avoid view controllers. A view controller in UIKit is a wrapper around a single view that provides notifications (appear, disappear, etc) and some state (orientation, navigation item, etc). Because of this extra layer, it can cause you to write a lot of delegate and callback code in order to coordinate between views. YOCView help to eliminate this view controller layer.

# Podfile

```ruby
pod "YOCView"
```

# Usage

Instead of making a view controller with a content view, just create your content view by subclassing YOCView.

```objc
#import <YOCView/YOCView.h>

@interface MainView : YOCView
@end
```

In the `AppDelegate` you can setup the root view controller with your main view like this:

```objc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  MainView *mainView = [[MainView alloc] init];
  self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[YOCView viewControllerForView:mainView]];
  
}
```

Then in your view you can push, pop, present, dismiss without worrying about view controllers.

```objc
@implementation MyView

- (void)pushAView {
  MyView *view = [[MyView alloc] init];
  [self.navigation pushView:view animated:YES];
}

- (void)presentAView {
  MyView *view = [[MyView alloc] init];
  [self.navigation presentView:view animated:YES];
}

- (void)popMyself {
  [self.navigation popViewAnimated:YES];
}

- (void)popToRoot {
  [self.navigation popToRootViewAnimated:YES];
}

- (void)dismissMyself {
  [self.navigation dismissAnimated:YES];
}

- (void)pushAViewHideNav {
  MyView *view = [[MyView alloc] init];
  view.viewOptions = YOCViewOptionsHideNavigation;
  [self.navigation pushView:view animated:YES];
}

@end
```

# View Notifications

`YOCView` has the following notifications:

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

# Example Project

The best way to follow and learn `YOCView` is by seeing it in action. Open the example project: [Example](https://github.com/gabriel/YOCView/tree/master/Example). 

# FAQ

## What if I need to access the view's UIViewController?

In your view, `self.viewController` will return the UIViewController it's in.

## Why does YOCView subclass YOView?

This allows support for [YOLayout](https://github.com/YOLayout/YOLayout). But you don't have to use it if you don't want. YOLayout doesn't override anything so you can pretend it's just like a UIView.

## But isn't this taking the C out of MVC? 

No.
