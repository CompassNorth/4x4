//
//  AdViewController.m
//  4x4
//
//  Created by François Helg on 09.12.19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdViewController.h"
#import "UILayoutHelpers.h"
#import "ColorProvider.h"
#import "UISpringButton.h"

static CGFloat kSideBuffer = 25;

@implementation AdViewController {
  UILabel *_titleLabel;
  UILabel *_questionLabel;
  NSMutableArray *answerButtons;
  UIButton *correctAnswer;
  int answerCount;
}

- (void)viewDidLoad {
  answerCount = 0;
  
  self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
  
  // Add the title
  _titleLabel = [UILabel new];
  _titleLabel.font = [UIFont boldSystemFontOfSize:50];
  _titleLabel.text = @"Quizz";
  _titleLabel.alpha = 1.0;
  _titleLabel.textColor = UIColor.blackColor;
  [self.view addSubview:_titleLabel];
  
  // Add the question
  _questionLabel = [UILabel new];
  _questionLabel.font = [UIFont boldSystemFontOfSize:50];
  _questionLabel.text = @"Question";
  _questionLabel.textColor = UIColor.blackColor;
  [self.view addSubview:_questionLabel];
  
  answerButtons = [NSMutableArray new];
  
  for (int i = 0; i < 3; i++) {
    // Add each answer
    // answerButton = [answerButtons objectAtIndex:i];
    UIButton* answerButton = [UISpringButton new];
    [answerButton setTitle:[self.answers objectAtIndex:i] forState:UIControlStateNormal];
    [answerButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [answerButton addTarget:self action:@selector(_didTapAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [UILayoutHelpers addStandardButtonInsets:answerButton];
    [self.view addSubview:answerButton];
    [answerButtons addObject:answerButton];
    
    if (self.correctAnswerIndex == i) {
      correctAnswer = answerButton;
    }
  }
  
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  // const CGFloat width = [UIScreen mainScreen].bounds.size.width;
  // const CGFloat height = [UIScreen mainScreen].bounds.size.height;
  // const CGFloat bubbles_width = width - kSideBuffer * 2;
  
  _titleLabel.frame = CGRectMake(0, 200, 0, 0);
  [_titleLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_titleLabel withinView:self.view];
  
  _questionLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 20, 0, 0);
  [_questionLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_questionLabel withinView:self.view];
  
  for (int i = 0; i < answerButtons.count; i++) {
    UIButton* answerButton = [answerButtons objectAtIndex:i];
    if (i > 0) {
      UIButton* previousAnswerButton = [answerButtons objectAtIndex:(i-1)];
      answerButton.frame = CGRectMake(0, CGRectGetMaxY(previousAnswerButton.frame) + 20, 0, 0);
    } else {
      answerButton.frame = CGRectMake(0, CGRectGetMaxY(_questionLabel.frame) + 20, 0, 0);
    }
    
    [answerButton sizeToFit];
    [UILayoutHelpers horizontallyCenterView:answerButton withinView:self.view];
  }
}
  
#pragma mark - Private

- (void)_didTapAnswer:(UIButton *)selectedButton
{
  if (correctAnswer == selectedButton) {
    for (UIButton *button in answerButtons) {
      if (button == selectedButton) {
        [button setBackgroundColor:UIColor.greenColor];
      } else {
        [button setBackgroundColor:UIColor.redColor];
      }
    }

    [self performSelector:@selector(_dismissSelf) withObject:self afterDelay:0.5];

  } else {
    [selectedButton setBackgroundColor:UIColor.redColor];
    selectedButton.enabled = NO;
    answerCount += 1;
  }
  
  [self.view setNeedsLayout];
}

- (void)_dismissSelf
{
  [self dismissViewControllerAnimated:YES completion:Nil];
  // Add coins and show coin image
}


@end
