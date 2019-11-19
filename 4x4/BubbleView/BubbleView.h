//
//  BubbleView.h
//  4x4
//
//  Created by Nicole Maguire on 11/8/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef BubbleView_h
#define BubbleView_h

#import <UIKit/UIKit.h>
#import "IndBubble.h"

@protocol BubbleViewDelegate <NSObject>

- (void)bubbleViewTouchesBegan:(UITouch *)touch;
- (void)bubbleViewTouchesMoved:(UITouch *)touch;
- (void)bubbleViewTouchesEnded:(UITouch *)touch;
- (void)bubbleViewTouchesCancelled:(UITouch *)touch;

@end

@interface BubbleView : UIView

@property (nonatomic, weak, nullable) UIViewController<BubbleViewDelegate> *delegate;
@property (nonatomic, strong) NSArray<NSArray<IndBubble *> *> *bubbles;
- (CGFloat)bubbleSize;
- (IndBubble *)bubbleForTouch:(UITouch *)touch;
- (bool)doesBubble:(IndBubble *)bubble
       touchBubble:(IndBubble *)otherBubble;
- (void)removeBubble:(IndBubble *)bubble;
- (void)addBubbleInColumn:(int)column;
- (int)columnForBubble:(IndBubble *)bubble;
- (void)cascadeBubbles;
- (void)refillBubbles;
- (NSArray<IndBubble *> *)borderingBubblesOfBubble:(IndBubble *)bubble;

@end


#endif /* BubbleView_h */
