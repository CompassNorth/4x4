//
//  InterstitialPresenter.h
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef InterstitialPresenter_h
#define InterstitialPresenter_h
#import <UIKit/UIKit.h>

@class InterstitialPresenter;

@protocol InterstitialPresenterDelegate <NSObject>

- (void)interstitialPresenter:(InterstitialPresenter *)presenter
                 didEarnCoins:(int)coinsEarned;

@end

@interface InterstitialPresenter : NSObject

- (void)showInterstitialFromViewController:(UIViewController *)controller;

@property (nonatomic, weak, nullable) NSObject<InterstitialPresenterDelegate> *delegate;

@end


#endif /* InterstitialPresenter_h */
