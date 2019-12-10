//
//  UILayoutHelpers.m
//  4x4
//
//  Created by Nicole Maguire on 11/16/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UILayoutHelpers.h"

@implementation UILayoutHelpers

+ (void)horizontallyCenterView:(UIView *)view
                    withinView:(UIView *)outerView
{
  CGFloat outerWidth = outerView.frame.size.width;
  CGFloat innerWidth = view.frame.size.width;

  view.frame = CGRectMake((outerWidth - innerWidth) / 2,
                          view.frame.origin.y,
                          innerWidth,
                          view.frame.size.height);
}

+ (void)addStandardButtonInsets:(UIButton *)button
{
  button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
}

@end
