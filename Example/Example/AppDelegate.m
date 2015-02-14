//
//  AppDelegate.m
//  GHUICatalog
//
//  Created by Gabriel Handford on 11/5/13.
//  Copyright (c) 2013 Gabriel Handford. All rights reserved.
//

#import "AppDelegate.h"

#import "GHAView.h"
#import <YOCView/YOCView.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];

  GHAView *mainView = [[GHAView alloc] init];
  UIViewController *viewController = [YOCViewController viewControllerForView:mainView];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  self.window.rootViewController = navigationController;

  [self.window makeKeyAndVisible];
  return YES;
}

@end
