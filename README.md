YOCView
=========

YOCView helps you avoid dealing with UIViewController. This can help avoid unnecessary delegate and callback boilerplate.

# Podfile

```ruby
pod "YOCView"
```

# Usage

Instead of making a UIViewController with a UIView, you can create a view and subclass YOCView (skipping the UIViewController step).

```objc
#import <YOCView/YOCView.h>

@interface MainView : YOCView
@end
```

Then within your view you can push, pop, present, dismiss without worrying about UIViewController.

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

To make a view the content for a window you can use `:`.

```objc
MainView *mainView = [[MainView alloc] init]; // Subclasses YOCView
UIViewController *viewController = [YOCView viewControllerForView:mainView];
UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
self.window.rootViewController = navigationController;
```

Here is an example of an `AppDelegate` that has a log in and main view.

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  if (loggedIn) {
    [self showMainView];
  } else {
    LogInView *logInView = [[LogInView alloc] init];
    logInView.delegate = self;
    [logInView setRootNavigationOnWindow:self.window];
  }

}

- (void)showMainView {
  MainView *mainView = [[MainView alloc] init]; // Subclasses YOCView
  [mainView setRootNavigationOnWindow:self.window]; // Sets the main view on the window
}

- (void)logInViewDidLogIn:(LogInView *)logInView {
  [self showMainView];
}
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

# Accessing your UIViewController

Sometimes you need to acces the UIViewControllers for things like alerts or search displays.

Calling `self.navigation.viewController` will give you access to your view controller.

```objc
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:@"An alert view" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
[self.navigation.viewController dismissViewControllerAnimated:YES completion:nil];
}]];
[self.navigation.viewController presentViewController:alert animated:YES completion:nil];
```

# Example Project

The best way to follow and learn `YOCView` is by seeing it in action. Open the example project: [Example](https://github.com/gabriel/YOCView/tree/master/Example).

