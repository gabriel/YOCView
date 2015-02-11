//
//  GHMainView.m
//  Example
//
//  Created by Gabriel on 2/10/15.
//  Copyright (c) 2015 Gabriel Handford. All rights reserved.
//

#import "GHAView.h"

#import <GHUITable/GHUITable.h>

#import "GHUITextImageView.h"
#import "GHAView.h"

@interface GHAView ()
@property GHUITableView *tableView;
@end

@implementation GHAView

- (void)viewInit {
  [super viewInit];
  self.navigationTitle = @"YOCView";

  _tableView = [[GHUITableView alloc] init];
  [self addSubview:_tableView];

  GHUITextImageView *pushView = [[GHUITextImageView alloc] init];
  [pushView setName:@"Push" description:nil image:nil];
  pushView.action = ^{
    GHAView *view = [[GHAView alloc] init];
    [self.navigation pushView:view animated:YES];
  };

//  GHUITextImageView *swapView = [[GHUITextImageView alloc] init];
//  [swapView setName:@"Swap" description:nil image:nil];
//  swapView.action = ^{
//    GHAView *view = [[GHAView alloc] init];
//    [self.navigation swapView:view animated:YES];
//  };

  GHUITextImageView *popView = [[GHUITextImageView alloc] init];
  [popView setName:@"Pop" description:nil image:nil];
  popView.action = ^{
    [self.navigation popViewAnimated:YES];
  };

  GHUITextImageView *popToRootView = [[GHUITextImageView alloc] init];
  [popToRootView setName:@"Pop to root" description:nil image:nil];
  popToRootView.action = ^{
    [self.navigation popToRootViewAnimated:YES];
  };

  GHUITextImageView *presentView = [[GHUITextImageView alloc] init];
  [presentView setName:@"Present" description:nil image:nil];
  presentView.action = ^{
    GHAView *view = [[GHAView alloc] init];
    [self.navigation presentView:view animated:YES completion:nil];
  };

//  GHUITextImageView *presentModalView = [[GHUITextImageView alloc] init];
//  [presentModalView setName:@"Present (Popover)" description:nil image:nil];
//  presentModalView.action = ^{
//    GHAView *view = [[GHAView alloc] init];
//    [self.navigation presentView:view modalPresentationStyle:UIModalPresentationPopover completion:nil];
//  };

  GHUITextImageView *dismissView = [[GHUITextImageView alloc] init];
  [dismissView setName:@"Dismiss" description:nil image:nil];
  dismissView.action = ^{
    [self.navigation dismissViewAnimated:YES completion:nil];
  };

  [_tableView.dataSource addObjects:@[pushView, popView, popToRootView] section:0];
  [_tableView.dataSource addObjects:@[presentView, dismissView] section:1];

  _tableView.dataSource.selectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, GHUITextImageView *view) {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    view.action();
  };
}

- (void)viewDidLoadWithLayout {
  [super viewDidLoadWithLayout];
  _tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0);

  // To help show stack info
  self.navigationTitle = [NSString stringWithFormat:@"#%@", @(self.navigation.viewController.navigationController.viewControllers.count)];
}

- (void)layoutSubviews {
  _tableView.frame = self.bounds;
}

@end
