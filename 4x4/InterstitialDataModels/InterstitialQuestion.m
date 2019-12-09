//
//  InterstitialQuestion.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InterstitialQuestion.h"

@implementation InterstitialQuestion

- (instancetype)initWithQuestion:(NSString *)question
                         answers:(NSArray<NSString *> *)answers
              correctAnswerIndex:(int)index{
  if (self = [super init]) {
    _question = question;
    _answers = answers;
    if (index < _answers.count) {
      _correctAnswerIndex = index;
    } else {
      _correctAnswerIndex = 0;
    }
  }
  return self;
}

- (bool)isAnswerCorrect:(NSString *)answer
{
  return [answer isEqualToString:_answers[_correctAnswerIndex]];
}

@end
