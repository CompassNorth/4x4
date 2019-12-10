//
//  UILayoutHelpers.h
//  4x4
//
//  Created by Nicole Maguire on 11/16/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef UILayoutHelpers_h
#define UILayoutHelpers_h
#import <UIKit/UIKit.h>

@interface UILayoutHelpers : NSObject

+ (void)horizontallyCenterView:(UIView *)view
                    withinView:(UIView *)outerView;

+ (void)rightSideOffsetView:(UIView *)view
                 withinView:(UIView *)outerView
                   byOffset:(CGFloat)offset;

+ (void)addStandardButtonInsets:(UIButton *)button;

@end


#endif /* UILayoutHelpers_h */
