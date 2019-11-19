//
//  BubbleViewController.h
//  4x4
//
//  Created by Nicole Maguire on 11/13/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef BubbleViewController_h
#define BubbleViewController_h

#import <UIKit/UIKit.h>

@protocol BubbleViewControllerDelegate <NSObject>

- (void)pointsCollected:(int)points;
- (void)noMoreMoves;

@end

@interface BubbleViewController : UIViewController

@property (nonatomic, weak, nullable) UIViewController<BubbleViewControllerDelegate> *delegate;

@end

#endif /* BubbleViewController_h */
