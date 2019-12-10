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
  UILabel *_additionalInformationLabel;
  UIButton *_exitButton;
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
  _titleLabel.text = @"Pop Quiz";
  _titleLabel.alpha = 1.0;
  _titleLabel.textColor = UIColor.blackColor;
  [self.view addSubview:_titleLabel];
  
  // Add the question
  _questionLabel = [UILabel new];
  _questionLabel.font = [UIFont systemFontOfSize:30];
  _questionLabel.numberOfLines = 0;
  _questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
  _questionLabel.textAlignment = NSTextAlignmentCenter;
  _questionLabel.text = _question;
  _questionLabel.textColor = UIColor.blackColor;
  [self.view addSubview:_questionLabel];
  
  _additionalInformationLabel = [UILabel new];
  _additionalInformationLabel.numberOfLines = 0;
  _additionalInformationLabel.lineBreakMode = NSLineBreakByWordWrapping;
  _additionalInformationLabel.textAlignment = NSTextAlignmentCenter;
  _additionalInformationLabel.text = _additionalInformation;
  _additionalInformationLabel.hidden = YES;
  [self.view addSubview:_additionalInformationLabel];
  
  answerButtons = [NSMutableArray new];
  
  for (int i = 0; i < _answers.count; i++) {
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
  
  _titleLabel.frame = CGRectMake(0, 75, 0, 0);
  [_titleLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_titleLabel withinView:self.view];
  
  CGSize questionSize = [_questionLabel sizeThatFits:self.view.frame.size];
  _questionLabel.frame = CGRectMake(0,
                                    CGRectGetMaxY(_titleLabel.frame) + 20,
                                    questionSize.width,
                                    questionSize.height);
  [UILayoutHelpers horizontallyCenterView:_questionLabel withinView:self.view];
  
  CGRect finalAnswerFrame;
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
    
    finalAnswerFrame = answerButton.frame;
  }
  
  CGSize extraSize = [_additionalInformationLabel sizeThatFits:self.view.frame.size];
  _additionalInformationLabel.frame = CGRectMake(0, CGRectGetMaxY(finalAnswerFrame) + 20, extraSize.width, extraSize.height);
  [UILayoutHelpers horizontallyCenterView:_additionalInformationLabel withinView:self.view];
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
    _additionalInformationLabel.hidden = NO;
    [_delegate interstitialFinishedWithCoins:2];
    [self performSelector:@selector(_dismissSelf) withObject:self afterDelay:1]; //MOVE THIS INTO THE X BUTTOn
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
}


@end
