//
//  BubbleView.m
//  4x4
//
//  Created by Nicole Maguire on 11/8/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BubbleView.h"
#import "IndBubble.h"

static CGFloat kBubbleSideBuffer = 10;

@implementation BubbleView 

- (instancetype)init{
  if (self = [super init]) {
    [self _createBubbles];
  }
  return self;
}

- (void)layoutSubviews{
  [super layoutSubviews];

  const CGFloat bubbleSize = [self bubbleSize];

  for (int i = 0; i < _bubbles.count; i++) {
    for (int j = 0; j < _bubbles[i].count; j++) {
      _bubbles[i][j].frame = CGRectMake((bubbleSize + kBubbleSideBuffer) * i, (bubbleSize + kBubbleSideBuffer) * j, bubbleSize, bubbleSize);
    }
  }
}

#pragma mark - Public

- (CGFloat)bubbleSize
{
  return (self.frame.size.height - (6 * kBubbleSideBuffer)) / 5;
}

- (IndBubble *)bubbleForTouch:(UITouch *)touch
{
  const int column = [self _columnForTouch:touch];
  const int row = [self _rowForTouch:touch];

  return _bubbles[column][row];
}

- (bool)doesBubble:(IndBubble *)bubble
       touchBubble:(IndBubble *)otherBubble
{
  //same row
  if (bubble == otherBubble) {
    return NO;
  }

  int column = [self columnForBubble:bubble];
  int row = [self _rowForBubble:bubble
                      forColumn:column];

  int otherColumn = [self columnForBubble:otherBubble];
  int otherRow = [self _rowForBubble:otherBubble
                           forColumn:otherColumn];

  // invalid row
  if (row == -1 || column == -1 || otherRow == -1 || otherColumn == -1) {
    return NO;
  }

  //bordering row
  int total = abs(row - otherRow) + abs(column - otherColumn);
  if (total == 1) {
    return YES;
  }

  return NO;
}

- (void)removeBubble:(IndBubble *)bubble
{
  [bubble removeFromSuperview];
  [self setNeedsLayout];
}

- (void)addBubbleInColumn:(int)column{}

- (int)columnForBubble:(IndBubble *)bubble
{
  for (int i = 0; i < _bubbles.count; i++) {
    if ([_bubbles[i] containsObject:bubble]) {
      return i;
    }
  }
  return -1;
}

- (void)cascadeBubbles{
  for (NSMutableArray<IndBubble *> *column in _bubbles) {
    int moveSpace = 0;
    for (int i = column.count - 1; i > -1; i--) {
      if (!column[i].superview) {
        moveSpace++;
      } else {
        column[i + moveSpace] = column[i];
        if (moveSpace > 0) {
          column[i] = [IndBubble new];
          [self addSubview:column[i]];
        }
      }
    }
    [self setNeedsLayout];
  }
}

- (void)refillBubbles{
  for (NSMutableArray<IndBubble *>* column in _bubbles) {
    for (int i = column.count - 1; i > -1; i--) {
      if (!column[i].superview){
        column[i] = [IndBubble new];
        [self addSubview:column[i]];
      }
    }
  }
  [self setNeedsLayout];
}

- (NSArray<IndBubble *> *)borderingBubblesOfBubble:(IndBubble *)bubble
{
  NSMutableArray<IndBubble *> *borderBubbles = [NSMutableArray new];
  int column = [self columnForBubble:bubble];
  int row = [self _rowForBubble:bubble forColumn:column];

  if (row < 4) {
    //grab the up bubble
    [borderBubbles addObject:_bubbles[column][row + 1]];
  }
  if (row > 0) {
    //grab the down bubbles
    [borderBubbles addObject:_bubbles[column][row - 1]];
  }
  if (column < 4) {
    // grab the right bubble
    [borderBubbles addObject:_bubbles[column + 1][row]];
  }
  if (column > 0) {
    // grab the left bubble
    [borderBubbles addObject:_bubbles[column - 1][row]];
  }
  return borderBubbles;
}


#pragma mark - Private

- (void)_createBubbles
{
  NSMutableArray *array = [NSMutableArray new];
  for (int i = 0; i < 5; i++) {
    array[i] = [self _createBubbleRow];
  }
  _bubbles = array;
}

- (NSArray<IndBubble *>*)_createBubbleRow
{
  NSMutableArray *array = [NSMutableArray new];
  for (int i = 0; i < 5; i++) {
    UIView *bubble = [IndBubble new];
    bubble.tag = i;
    array[i] = bubble;
    [self addSubview:bubble];
  }
  return array;
}

- (int)_rowForBubble:(IndBubble *)bubble
           forColumn:(int)column
{
  if (column < 0 || column > 4)
  {
    return -1;
  }
  for (int i = _bubbles[column].count - 1; i > -1 ; i--) {
    if (_bubbles[column][i] == bubble) {
      return i;
    }
  }
  return -1;
}

- (int)_columnForTouch:(UITouch *)touch
{
  CGPoint touchLocation = [touch locationInView:self];
  int column = touchLocation.x / ([self bubbleSize] + kBubbleSideBuffer);
  return column % 5;
}

- (int)_rowForTouch:(UITouch *)touch
{
  CGPoint touchLocation = [touch locationInView:self];
  int row = (touchLocation.y / ([self bubbleSize] + kBubbleSideBuffer));
  return row % 5;
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [_delegate bubbleViewTouchesBegan:[touches anyObject]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [_delegate bubbleViewTouchesMoved:[touches anyObject]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [_delegate bubbleViewTouchesEnded:[touches anyObject]];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [_delegate bubbleViewTouchesCancelled:[touches anyObject]];
}

@end
