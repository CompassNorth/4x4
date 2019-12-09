//
//  IndBubble.h
//  4x4
//
//  Created by Nicole Maguire on 11/8/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef IndBubble_h
#define IndBubble_h

#import <UIKit/UIKit.h>

@interface IndBubble : UIView

@property (nonatomic, weak) NSNumber *bubbleValue;
@property (nonatomic, assign) Boolean isPressed;

- (void)randomize;

@end

#endif /* IndBubble_h */
