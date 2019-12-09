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
    // TODO : Make this actually spring
    //[self addTarget:self action:@selector(animateButton) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)animateButton {
  [UIView animateWithDuration:1
                   delay:0
  usingSpringWithDamping:0.55
   initialSpringVelocity:12
                 options:UIViewAnimationOptionBeginFromCurrentState
              animations:^{
                self.transform = CGAffineTransformMakeScale(0.9, 1);
              }
              completion:^(BOOL finished) {
                self.transform = CGAffineTransformIdentity;
              }];
}

@end
