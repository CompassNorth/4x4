//
//  InterstitialViewControllerDelegate.h
//  4x4
//
//  Created by Nicole Maguire on 12/10/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef InterstitialViewControllerDelegate_h
#define InterstitialViewControllerDelegate_h

@protocol InterstitialViewControllerDelegate <NSObject>

- (void)interstitialFinishedWithCoins:(int)coinsEarned;

@end

#endif /* InterstitialViewControllerDelegate_h */
