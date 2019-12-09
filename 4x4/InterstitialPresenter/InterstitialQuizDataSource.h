//
//  InterstitialQuizDataSource.h
//  4x4
//
//  Created by Nicole Maguire on 12/9/19.
//  Copyright © 2019 Nicole Maguire. All rights reserved.
//

#ifndef InterstitialQuizDataSource_h
#define InterstitialQuizDataSource_h
#import "InterstitialQuestion.h"

@interface InterstitialQuizDataSource : NSObject

+(NSArray<InterstitialQuestion *> *)dataSourceQuestions;

@end


#endif /* InterstitialQuizDataSource_h */
