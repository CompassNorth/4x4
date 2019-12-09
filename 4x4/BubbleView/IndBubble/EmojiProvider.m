//
//  EmojiProvider.m
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EmojiProvider.h"

@implementation EmojiProvider

/*
+(UIColor *)fontColor;
+(UIColor *)twoColor;
+(UIColor *)fourColor;
+(UIColor *)eightColor;
+(UIColor *)sixteenColor;
+(UIColor *)threeTwoColor;
+(UIColor *)sixFourColor;
+(UIColor *)oneTwoEightColor;
+(UIColor *)twoFourEightColor;
+(UIColor *)fourNineSixColor;
+(UIColor *)onekColor;
+(UIColor *)twokColor;
+(UIColor *)fourkColor;
+(UIColor *)eightkColor;
+(UIColor *)sixteenkColor;
 */
+ (NSString *)emojiForValue:(int)value;
{
  switch (value) {
    case 2:
      return @"❤️";
    case 4:
      return @"🎉";
    case 8:
      return @"🤣";
    case 16:
      return @"🙏";
    case 32:
      return @"🐙";
    case 64:
      return @"🔥";
    case 128:
      return @"👍";
    case 248:
      return @"🐠";
    case 496:
      return @"🐢";
    case 992:
      return @"💎";
    case 1984:
      return @"💩";
    case 3968:
      return @"💰";
    case 7936:
      return @"🚀";
    case 15872:
      return @"✨";
    default:
      return @"ERROR";
  }
}

@end
