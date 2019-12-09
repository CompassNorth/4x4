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

@implementation InterstitialPresenter

- (void)showInterstitialFromViewController:(UIViewController *)controller
{
  UIViewController *nextVC = [AdViewController new]; // TODO: Randomize which one is shown, make sure the same one isn't shown multiple times
  [controller showViewController:nextVC sender:self];
}

@end
