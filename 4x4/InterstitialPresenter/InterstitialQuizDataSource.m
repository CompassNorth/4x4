//
//  InterstitialQuizDataSource.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterstitialQuizDataSource.h"

@implementation InterstitialQuizDataSource

+(NSArray<InterstitialQuestion *> *)dataSourceQuestions
{
  NSArray<NSString *> *answers = @[@"A funny joke", @"Where you are", @"Your phone number"];
  InterstitialQuestion *tellStranger = [[InterstitialQuestion alloc] initWithQuestion:@"Which of these is okay to tell someone you met online" answers:answers correctAnswerIndex:0];

  answers = @[@"Tell a friend", @"Tell an adult", @"Nothing"];
  InterstitialQuestion *uncomfy = [[InterstitialQuestion alloc] initWithQuestion:@"What should you do if someone on the internet makes you feel sad, scared, or confused?" answers:answers correctAnswerIndex:1];

  return @[tellStranger, uncomfy];
}

+(NSArray<NSURL *> *)dataSourceVideos
{
  NSArray<NSString *> *stringURLs = @[@"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb-hackathon/5%20Internet%20Safety%20Tips%20for%20Kids_part_1.mp4",
                                      @"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb-hackathon/5%20Internet%20Safety%20Tips%20for%20Kids_part_2.mp4",
                                      @"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb-hackathon/5%20Internet%20Safety%20Tips%20for%20Kids_part_3.mp4",
                                      @"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb-hackathon/5%20Internet%20Safety%20Tips%20for%20Kids_part_4.mp4",
                                      @"https://sos-ch-dk-2.exo.io/eu.privately.file.sharing/fb-hackathon/5%20Internet%20Safety%20Tips%20for%20Kids_part_5.mp4",];
  NSMutableArray<NSURL *>* videoURLs = [NSMutableArray new];
  for (NSString *urlString in stringURLs) {
    [videoURLs addObject:[NSURL URLWithString:urlString]];
  }

  return videoURLs;
}

@end
