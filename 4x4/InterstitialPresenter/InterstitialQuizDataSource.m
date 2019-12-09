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

  return @[tellStranger];
}

@end
