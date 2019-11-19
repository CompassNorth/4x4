//
//  BubbleViewController.m
//  4x4
//
//  Created by Nicole Maguire on 11/13/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleViewController.h"
#import "BubbleView.h"
#import "IndBubble.h"

@interface BubbleViewController() <
  BubbleViewDelegate
>
@end

@implementation BubbleViewController {
  NSMutableArray<IndBubble *> *_activatedBubbles;
  BubbleView *_bubbleView;
  IndBubble *_lastBubble;
}

- (instancetype)init
{
  if (self = [super init]) {
    _activatedBubbles = [NSMutableArray new];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  _bubbleView = [BubbleView new];
  _bubbleView.delegate = self;
  [self.view addSubview:_bubbleView];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];

  _bubbleView.frame = self.view.bounds;
}

#pragma mark - BubbleViewDelegate
- (void)bubbleViewTouchesBegan:(UITouch *)touch{
  IndBubble *bubble = [_bubbleView bubbleForTouch:touch];
  [self _activateBubble:bubble];
}
- (void)bubbleViewTouchesMoved:(UITouch *)touch{
  IndBubble *bubble = [_bubbleView bubbleForTouch:touch];
  if ([self _canTouchBubble:bubble fromBubble:_lastBubble]) {
    [self _activateBubble:bubble];
  }
}
- (void)bubbleViewTouchesEnded:(UITouch *)touch{
  [self _scoreBubbles:_activatedBubbles];
  [self _compressBubbles:_activatedBubbles endingBubble:_lastBubble];
  [self _turnOffActivatedBubbles];
  [self _checkForRemainingMoves];
}
- (void)bubbleViewTouchesCancelled:(UITouch *)touch{
  [self _turnOffActivatedBubbles];
}

#pragma mark - Private

- (void)_activateBubble:(IndBubble *)bubble
{
  bubble.isPressed = YES;
  [_activatedBubbles addObject:bubble];
  _lastBubble = bubble;
}

- (void)_turnOffActivatedBubbles
{
  for (IndBubble *bubble in _activatedBubbles) {
    bubble.isPressed = NO;
  }
  [_activatedBubbles removeAllObjects];
}

- (bool)_canTouchBubble:(IndBubble *)bubble
             fromBubble:(IndBubble *)otherBubble
{
  bool bubbleBorders = [_bubbleView doesBubble:bubble touchBubble:_lastBubble];
  bool sameBubble = bubble.bubbleValue == otherBubble.bubbleValue;
  return bubbleBorders && sameBubble && !bubble.isPressed;
}

- (void)_compressBubbles:(NSArray<IndBubble *> *) allBubbles
            endingBubble:(IndBubble *)endingBubble
{
  //calculate final bubble
  int totalValue = [allBubbles[0].bubbleValue integerValue] * allBubbles.count;
  int rounded = pow(2, floor(log(totalValue)/log(2)));
  endingBubble.bubbleValue = [NSNumber numberWithInt:rounded];

  //reset all bubbles except final bubble
  for (IndBubble *bubble in allBubbles) {
    if (!(bubble == endingBubble)) {
      [_bubbleView removeBubble:bubble];
    }
  }

  [_bubbleView cascadeBubbles];
  [_bubbleView refillBubbles];
}

- (void)_scoreBubbles:(NSArray<IndBubble *> *) allBubbles
{
  if (allBubbles.count == 1) {
    return;
  }

  int score = 0;
  for (IndBubble *bubble in allBubbles) {
    score += [bubble.bubbleValue integerValue];
  }
  // TODO : Add a multiplier
  [_delegate pointsCollected:score];
}

- (void)_checkForRemainingMoves
{
  for (NSArray<IndBubble *> *bubbles in _bubbleView.bubbles) {
    for (IndBubble *bubble in bubbles) {
      NSArray *borderingBubbles = [_bubbleView borderingBubblesOfBubble:bubble];
      for (IndBubble *borderBubble in borderingBubbles) {
        if (bubble.bubbleValue == borderBubble.bubbleValue) {
          return;
        }
      }
    }
  }

  [_delegate noMoreMoves];
}

@end
