//
//  ColorProvider.m
//  4x4
//
//  Created by Nicole Maguire on 11/13/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorProvider.h"

@implementation ColorProvider

+(UIColor *)backgroundColor
{
  return [UIColor blueColor];
}

+(UIColor *)fontColor
{
  return [UIColor whiteColor];
}

+(UIColor *)twoColor
{
  return [UIColor colorWithRed:246/255.0 green:196/255.0 blue:201/255.0 alpha:1.0];
}

+(UIColor *)fourColor
{
  return [UIColor colorWithRed:157/255.0 green:213/255.0 blue:251/255.0 alpha:1.0];
}

+(UIColor *)eightColor
{
  return [UIColor colorWithRed:255/255.0 green:254/255.0 blue:201/255.0 alpha:1.0];
}

+(UIColor *)sixteenColor
{
  return [UIColor colorWithRed:133/255.0 green:188/255.0 blue:192/255.0 alpha:1.0];
}

+(UIColor *)threeTwoColor
{
  return [UIColor colorWithRed:192/255.0 green:183/255.0 blue:192/255.0 alpha:1.0];
}

+(UIColor *)sixFourColor
{
  return [UIColor colorWithRed:201/255.0 green:219/255.0 blue:191/255.0 alpha:1.0];
}

+(UIColor *)oneTwoEightColor
{
  return [UIColor colorWithRed:173/255.0 green:221/255.0 blue:206/255.0 alpha:1.0];
}

+(UIColor *)twoFourEightColor
{
  return [UIColor colorWithRed:248/255.0 green:210/255.0 blue:161/255.0 alpha:1.0];
}

+(UIColor *)fourNineSixColor
{
  return [UIColor colorWithRed:179/255.0 green:226/255.0 blue:232/255.0 alpha:1.0];
}

+(UIColor *)onekColor
{
  return [UIColor greenColor];
}

+(UIColor *)twokColor
{
  return [UIColor colorWithRed:191/255.0 green:177/255.0 blue:199/255.0 alpha:1.0];
}

+(UIColor *)fourkColor
{
  return [UIColor greenColor];
}

+(UIColor *)eightkColor
{
  return [UIColor greenColor];
}

+(UIColor *)sixteenkColor
{
  return [UIColor greenColor];
}

+(UIColor *)colorForValue:(int)value
{
  switch(value) {
    case 2:
      return [self twoColor];
    case 4:
      return [self fourColor];
    case 8:
      return [self eightColor];
    case 16:
      return [self sixteenColor];
    case 32:
      return [self threeTwoColor];
    case 64:
      return [self sixFourColor];
    case 128:
      return [self oneTwoEightColor];
    case 256:
      return [self twoFourEightColor];
    default:
      return [UIColor purpleColor];
  }
}

+ (UIColor *)errorColor
{
  return [UIColor redColor];
}

@end

