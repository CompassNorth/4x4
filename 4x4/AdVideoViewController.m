//
//  AdVideoViewController.m
//  4x4
//
//  Created by François Helg on 09.12.19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import "AdVideoViewController.h"

@interface AdVideoViewController () {
  NSURL *videoURL;
}
@end

@implementation AdVideoViewController

@synthesize playerViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //NSString *fullpath = [[self documentsDirectory] stringByAppendingPathComponent:@"20191209_134415.mp4"];
  //NSLog(@"Path %@", fullpath);
  videoURL = [NSURL URLWithString:@"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb_hackathon_test.mp4"];
  AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoURL];
  AVPlayer* playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
  playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = playVideo;
  playerViewController.player.volume = 0;
  playerViewController.view.frame = self.view.bounds;
  [self.view addSubview:playerViewController.view];
  [playVideo play];
}

-(NSString *)documentsDirectory{
 NSArray *paths =
 NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 return documentsDirectory;
}
/*
#pragma mark - Navigation
			
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
