//
//  InterstitialPresenter.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterstitialPresenter.h"
#import "AdVideoViewController.h"
#import "AdViewController.h"
#import "InterstitialQuestion.h"
#import "InterstitialQuizDataSource.h"
#import "InterstitialViewControllerDelegate.h"

@interface InterstitialPresenter () <
  InterstitialViewControllerDelegate
>
@end

@implementation InterstitialPresenter {
  int _currentQuizTipCount;
  int _currentVideoTipCount;
  bool _showVideo; 
  NSArray<InterstitialQuestion *> *_questions;
  NSArray<NSURL *> *_videoURLs;
}

- (instancetype)init {
  if (self = [super init]) {
    _currentQuizTipCount = 0;
    _currentVideoTipCount = 0;
    _showVideo = YES;
    _questions = [InterstitialQuizDataSource dataSourceQuestions];
    _videoURLs = [InterstitialQuizDataSource dataSourceVideos];
  }
  return self;
}

- (void)showInterstitialFromViewController:(UIViewController *)controller
{
  UIViewController *nextVC = [self _createTipVC];
  [controller showViewController:nextVC sender:self];
}

#pragma mark - InterstitialViewControllerDelegate

- (void)interstitialFinishedWithCoins:(int)coinsEarned
{
  [_delegate interstitialPresenter:self didEarnCoins:coinsEarned];
}

#pragma mark - Private

- (UIViewController *)_createTipVC
{
  UIViewController *tipVC;
  if (_showVideo) {
    tipVC = [self _createVideoTipVC];
  } else {
    tipVC = [self _createQuestionTipVC];
  }
  _showVideo = !_showVideo;
  return tipVC;
}

- (UIViewController *)_createVideoTipVC
{
  if (_currentVideoTipCount >= _videoURLs.count) {
    _currentVideoTipCount = 0;
  }

  [self interstitialFinishedWithCoins:2];
  AdVideoViewController *vc = [AdVideoViewController new];
  vc.videoUrl = _videoURLs[_currentVideoTipCount++];
  return vc;
}

- (UIViewController *)_createQuestionTipVC
{
  if (_currentQuizTipCount >= _questions.count) {
    _currentQuizTipCount = 0;
  }
  InterstitialQuestion *question = _questions[_currentQuizTipCount++];

  AdViewController *vc = [AdViewController new];
  vc.question = question.question;
  vc.answers = question.answers;
  vc.correctAnswerIndex = question.correctAnswerIndex;
  vc.additionalInformation = question.additionalInformation;
  vc.delegate = self;
  return vc;
}

@end
