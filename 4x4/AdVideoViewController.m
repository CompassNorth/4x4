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
@synthesize videoUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  NSString *fullpath = [[self documentsDirectory] stringByAppendingPathComponent:@"20191209_134415.mp4"];
  //NSLog(@"Path %@", fullpath);
  videoURL = [NSURL URLWithString:@"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb_hackathon_test.mp4"];
  AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoURL];
  AVPlayer* playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
  playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = playVideo;
  playerViewController.player.volume = 0;
  playerViewController.view.frame = self.view.bounds;
  [self.view addSubview:playerViewController.view];
  self.modalInPresentation = YES;

  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    self.modalInPresentation = NO;
  });
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
