//
//  ColorProvider.h
//  4x4
//
//  Created by Nicole Maguire on 11/13/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef ColorProvider_h
#define ColorProvider_h
#import <UIKit/UIKit.h>

@interface ColorProvider : NSObject

+(UIColor *)backgroundColor;
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
+(UIColor *)colorForValue:(int)value;
+(UIColor *)errorColor;
@end

#endif /* ColorProvider_h */
