//
//  ViewController.m
//  4x4
//
//  Created by Nicole Maguire on 11/8/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import "GameViewController.h"
#import "BubbleViewController.h"
#import "UILayoutHelpers.h"
#import "ColorProvider.h"

static CGFloat kSideBuffer = 25;
static CGFloat kUnderBuffer = 100;
static const NSString *kHighScoreKey = @"highScore";

@interface GameViewController () <
  BubbleViewControllerDelegate
>

@end

@implementation GameViewController{
  BubbleViewController *_bubbleViewController;
  UIButton *_newGameButton;
  UILabel *_scoreLabel;
  UILabel *_highScoreLabel;
  UILabel *_noMoreMovesLabel;
  double _score;
  double _highScore;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _bubbleViewController = [BubbleViewController new];
  _bubbleViewController.delegate = self;
  [self.view addSubview:_bubbleViewController.view];

  _newGameButton = [UIButton new];
  [_newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
  [_newGameButton addTarget:self action:@selector(_didTapNewGame) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_newGameButton];

  _scoreLabel = [UILabel new];
  _scoreLabel.font = [UIFont boldSystemFontOfSize:50];
  [self.view addSubview:_scoreLabel];

  _highScoreLabel = [UILabel new];
  [self.view addSubview:_highScoreLabel];

  _noMoreMovesLabel = [UILabel new];
  _noMoreMovesLabel.textColor = [ColorProvider errorColor];
  _noMoreMovesLabel.text = @"No more moves left in game.";
  _noMoreMovesLabel.hidden = YES;
  [self.view addSubview:_noMoreMovesLabel];

  [self _updateScore:0];
  [self _updateHighScore:[[[NSUserDefaults standardUserDefaults] valueForKey:kHighScoreKey] doubleValue]];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  const CGFloat width = [UIScreen mainScreen].bounds.size.width;
  const CGFloat height = [UIScreen mainScreen].bounds.size.height;
  const CGFloat bubbles_width = width - kSideBuffer * 2;
  _bubbleViewController.view.frame = CGRectMake(kSideBuffer,
                                 height - kUnderBuffer - bubbles_width,
                                 bubbles_width,
                                 bubbles_width);

  _newGameButton.frame = CGRectMake(50, 100, 0, 0);
  [_newGameButton sizeToFit];
  _newGameButton.backgroundColor = [UIColor blueColor];

  _scoreLabel.frame = CGRectMake(0, 200, 0, 0);
  [_scoreLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_scoreLabel withinView:self.view];

  _highScoreLabel.frame = CGRectMake(0, 260, 0, 0);
  [_highScoreLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_highScoreLabel withinView:self.view];

  _noMoreMovesLabel.frame = CGRectMake(50,
                                     CGRectGetMaxY(_bubbleViewController.view.frame) + 20,
                                     0,
                                     0);
  [_noMoreMovesLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_noMoreMovesLabel withinView:self.view];
}

#pragma mark - BubbleViewControllerDelegate

- (void)pointsCollected:(int)points
{
  [self _updateScore:_score + points];
}

- (void)noMoreMoves
{
  _noMoreMovesLabel.hidden = NO;
  [self.view setNeedsLayout];
}


#pragma mark - Private

- (void)_didTapNewGame
{
  _noMoreMovesLabel.hidden = YES;

  [self _updateScore:0];

  [_bubbleViewController.view removeFromSuperview];
  _bubbleViewController = [BubbleViewController new];
  _bubbleViewController.delegate = self;
  [self.view addSubview:_bubbleViewController.view];
  [self.view setNeedsLayout];
}

- (void)_updateScore:(int)score
{
  _score = score;
  _scoreLabel.text = [NSString stringWithFormat:@"%.0f", _score];
  if (_score > _highScore) {
    [self _updateHighScore:_score];
  }
  [self.view setNeedsLayout];
}

- (void)_updateHighScore:(double)score
{
  _highScore = score;
  _highScoreLabel.text = [NSString stringWithFormat:@"High Score : %.0f", _highScore];
  [[NSUserDefaults standardUserDefaults] setValue:@(_highScore) forKey:kHighScoreKey];
  [self.view setNeedsLayout];
}


@end
