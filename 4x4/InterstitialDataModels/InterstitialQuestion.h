//
//  InterstitialQuestion.h
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef InterstitialQuestion_h
#define InterstitialQuestion_h

@interface InterstitialQuestion : NSObject

- (instancetype)initWithQuestion:(NSString *)question
                         answers:(NSArray<NSString *> *)answers
              correctAnswerIndex:(int)index;

- (bool)isAnswerCorrect:(NSString *)answer;

@property int correctAnswerIndex;
@property NSString *question;
@property NSArray<NSString*> *answers;

@end


#endif /* InterstitialQuestion_h */
