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
#import "UISpringButton.h"

static CGFloat kSideBuffer = 25;
static CGFloat kUnderBuffer = 100;
static CGFloat kContentUnderBuffer = 10;
static CGFloat kNumberOfMovesBeforeInterstitial = 5;
static CGFloat kActionButtonSize = 60;
static CGFloat kActionButtonImageSize = 45;
static CGFloat kActionButtonBuffer = 25;
static const NSString *kHighScoreKey = @"highScore";

@interface GameViewController () <
  BubbleViewControllerDelegate
>

@end

@implementation GameViewController{
  BubbleViewController *_bubbleViewController;
  UISpringButton *_newGameButton;
  UISpringButton *_undoButton;
  UISpringButton *_shuffleButton;
  UISpringButton *_hammerButton;
  UIView *_actionButtonView;
  UILabel *_scoreLabel;
  UILabel *_highScoreLabel;
  UILabel *_noMoreMovesLabel;
  double _score;
  double _highScore;
  double _moveCount;
  double _coinCount;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _bubbleViewController = [BubbleViewController new];
  _bubbleViewController.delegate = self;
  [self.view addSubview:_bubbleViewController.view];

  _newGameButton = [UISpringButton new];
  [_newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
  [_newGameButton setTitleColor:ColorProvider.fontColor forState:UIControlStateNormal];
  [_newGameButton addTarget:self action:@selector(_didTapNewGame) forControlEvents:UIControlEventTouchUpInside];
  _newGameButton.backgroundColor = ColorProvider.oneTwoEightColor;
  _newGameButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
  [self.view addSubview:_newGameButton];

  _actionButtonView = [UIView new];
  [self.view addSubview:_actionButtonView];

  _shuffleButton = [self _createActionButtonWithImageName:@"shuffleIcon" backgroundColor:ColorProvider.twokColor];
  _undoButton = [self _createActionButtonWithImageName:@"undoIcon" backgroundColor:ColorProvider.fourNineSixColor];
  _hammerButton = [self _createActionButtonWithImageName:@"hammerIcon" backgroundColor:ColorProvider.onekColor];

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
  _moveCount = 0;
  _coinCount = 0;
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

  [self _layoutActionButtons];
  _actionButtonView.frame = CGRectMake(0,
                                       150,
                                       (kActionButtonSize * 3) + (kActionButtonBuffer * 2),
                                       kActionButtonSize);
  [UILayoutHelpers horizontallyCenterView:_actionButtonView withinView:self.view];

  _scoreLabel.frame = CGRectMake(0, CGRectGetMaxY(_actionButtonView.frame) + kContentUnderBuffer * 2, 0, 0);
  [_scoreLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_scoreLabel withinView:self.view];

  _highScoreLabel.frame = CGRectMake(0, CGRectGetMaxY(_scoreLabel.frame) + kContentUnderBuffer, 0, 0);
  [_highScoreLabel sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_highScoreLabel withinView:self.view];

  _newGameButton.frame = CGRectMake(0, CGRectGetMaxY(_highScoreLabel.frame) + kContentUnderBuffer, 0, 0);
  [_newGameButton sizeToFit];
  [UILayoutHelpers horizontallyCenterView:_newGameButton withinView:self.view];
  _newGameButton.layer.cornerRadius = _newGameButton.frame.size.height / 2;


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

- (UISpringButton *)_createActionButtonWithImageName:(NSString *)imageName
                                     backgroundColor:(UIColor *)backgroundColor
{
  UISpringButton *button = [UISpringButton new];
  UIImage *hammerImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  button.imageView.contentMode = UIViewContentModeScaleAspectFit;
  button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [button.imageView setTintColor:ColorProvider.fontColor];
  [button setImage:hammerImage forState:UIControlStateNormal];
  [button setTitleColor:ColorProvider.fontColor forState:UIControlStateNormal];
  button.backgroundColor = backgroundColor;
  [_actionButtonView addSubview:button];
  return button;
}

- (void)_layoutActionButtons
{
  _hammerButton.frame = CGRectMake(0, 0, kActionButtonSize, kActionButtonSize);
  _shuffleButton.frame = CGRectMake(kActionButtonBuffer + kActionButtonSize, 0, kActionButtonSize, kActionButtonSize);
  _undoButton.frame = CGRectMake((kActionButtonBuffer + kActionButtonSize) * 2, 0, kActionButtonSize, kActionButtonSize);
}

- (void)_didTapNewGame
{
  
  /*_noMoreMovesLabel.hidden = YES;

  [self _updateScore:0];

  [_bubbleViewController.view removeFromSuperview];
  _bubbleViewController = [BubbleViewController new];
  _bubbleViewController.delegate = self;
  [self.view addSubview:_bubbleViewController.view];
  [self.view setNeedsLayout];*/
}

- (void)_updateScore:(int)score
{
  [self _increaseMoveCount];
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

- (void)_increaseMoveCount
{
  _moveCount++;
  if (_moveCount >= kNumberOfMovesBeforeInterstitial) {
    [self _showInterstitial];
    _moveCount = 0;
  }
}

- (void)_showInterstitial
{
  // TODO : Transition into the child safety skill interstitial
}

- (void)_updateCoinCount:(double)coinsToAdd
{
  _coinCount += coinsToAdd;
  if (_coinCount > 0) {
    // TODO : Update the score bubble to reflect the number of coins
    // TODO : unlock hammer if the coin count is high enough (med coin)
    // TODO : unlock reshuffle if the coin is high enough (high coin)
    // TODO : unlock undo if the coin is high enough (low coin)
  }
}


@end
