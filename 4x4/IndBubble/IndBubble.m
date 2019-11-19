//
//  IndBubble.m
//  4x4
//
//  Created by Nicole Maguire on 11/8/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IndBubble.h"
#import "ColorProvider.h"

@implementation IndBubble {
  UILabel *_label;

}

- (instancetype)init{
  if (self = [super init]) {
    [self randomize];
    _isPressed = NO;
    _label = [UILabel new];
    _label.text = _bubbleValue.stringValue;
    [self addSubview:_label];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.layer.cornerRadius = self.frame.size.height / 2;

  [_label sizeToFit];
  _label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)setBubbleValue:(NSNumber *)bubbleValue
{
  _bubbleValue = bubbleValue;
  self.backgroundColor = [ColorProvider colorForValue:[_bubbleValue integerValue]];
  _label.text = _bubbleValue.stringValue;
  [self setNeedsLayout];
}

- (void)setIsPressed:(Boolean)isPressed
{
  _isPressed = isPressed;
  if (isPressed) {
    self.backgroundColor = [UIColor grayColor];
  } else {
    self.backgroundColor = [ColorProvider colorForValue:[_bubbleValue integerValue]];
  }

  [self _playHaptic:!isPressed];
}

- (void)randomize
{
  int randNum = 1 + arc4random() % (4 - 1);
  self.bubbleValue = [NSNumber numberWithInt:pow(2, randNum)];
}

#pragma mark - Private

- (void)_playHaptic:(bool)isLight
{
  UIImpactFeedbackGenerator *gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
  if (isLight) {
    gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
  }

  [gen prepare];
  [gen impactOccurred];
}


@end
