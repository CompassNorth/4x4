//
//  InterstitialPresenter.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterstitialPresenter.h"
#import "AdVideoViewController.h"
#import "AdViewController.h"

@implementation InterstitialPresenter {
  int _currentTipCount;
}

- (instancetype)init {
  if (self = [super init]) {
    _currentTipCount = 0;
  }
  return self;
}

- (void)showInterstitialFromViewController:(UIViewController *)controller
{
  UIViewController *nextVC = [self _createTipVCForIndex:_currentTipCount];
  [controller showViewController:nextVC sender:controller];
  _currentTipCount++;
}

- (UIViewController *)_createTipVCForIndex:(int)index
{
  return [self _createVideoTipVC];
}

- (UIViewController *)_createVideoTipVC
{
  return [AdVideoViewController new];
}

- (UIViewController *)_createQuestionTipVC
{
  return [AdViewController new];
}

@end
