//
//  AdVideoViewController.h
//  4x4
//
//  Created by François Helg on 09.12.19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdVideoViewController : UIViewController
@property (strong, nonatomic) AVPlayerViewController *playerViewController;
@property (strong, nonatomic) NSURL *videoUrl;
@end

NS_ASSUME_NONNULL_END
