YOCView
=========

Simplifying UIView and UIViewController interactions.

Instead of making a UIViewController subclass and a UIView subclass, you can create just a YOCView subclass.

```objc
#import <YOCView/YOCView.h>

@interface MainView : YOCView
@end
```


To create a view controller use: `[YOCViewController viewControllerForView:view];`. For example in your AppDelegate you might do:

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  MainView *mainView = [[MainView alloc] init]; // Subclasses YOCView
  UIViewController *viewController = [YOCView viewControllerForView:mainView];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  self.window.rootViewController = navigationController;
}
```

Then within your YOCView you can push, pop, present, dismiss by accessing `self.navigation`.

```objc
@implementation MyView

- (void)viewDidLoadWithLayout {
  [super viewDidLoadWithLayout];
  self.navigationTitle = @"Title";
}

- (void)pushAView {
  AnotherView *view = [[AnotherView alloc] init];
  [self.navigation pushView:view animated:YES];
}

- (void)presentAView {
  AnotherView *view = [[AnotherView alloc] init];
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
  AnotherView *view = [[AnotherView alloc] init];
  view.viewOptions = YOCViewOptionsHideNavigation;
  [self.navigation pushView:view animated:YES];
}

@end
```

# View Notifications

`YOCView` also gets the following notifications:

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

Calling `self.navigation.viewController` will give you access to your UIViewController. For example, to show an alert:

```objc

@implementation MyView

- (void)showAlert {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:@"An alert view" preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self.navigation.viewController dismissViewControllerAnimated:YES completion:nil];
  }]];
  [self.navigation.viewController presentViewController:alert animated:YES completion:nil];
}

@end
```

# Podfile

```ruby
pod "YOCView"
```

# Example Project

The best way to follow and learn `YOCView` is by seeing it in action. Open the example project: [Example](https://github.com/gabriel/YOCView/tree/master/Example).

