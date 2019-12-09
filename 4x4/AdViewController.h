//
//  AdViewController.h
//  4x4
//
//  Created by François Helg on 09.12.19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdViewController : UIViewController

@property int correctAnswerIndex;
@property NSString *quizzTitle;
@property NSString *question;
@property NSArray<NSString*> *answers;
@end

