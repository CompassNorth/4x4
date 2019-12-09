//
//  UISpringButton.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UISpringButton.h"

@implementation UISpringButton : UIButton

- (instancetype)init {
  if (self = [super init]) {
    [self addTarget:self action:@selector(animateButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  self.layer.cornerRadius = self.frame.size.height / 2;
}

- (void)animateButton {
  // TODO : Get this working
  return;
  [UIView animateWithDuration:0.5
                   delay:0
  usingSpringWithDamping:0.2
   initialSpringVelocity:12
                 options:UIViewAnimationOptionBeginFromCurrentState
              animations:^{
                self.transform = CGAffineTransformMakeScale(0.9, 0.9);
              }
              completion:^(BOOL finished) {
                //self.transform = CGAffineTransformIdentity;
              }];
}

@end
