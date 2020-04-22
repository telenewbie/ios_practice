//
//  BlockTest.h
//  ProcessIOS
//
//  Created by newbie on 2020/4/10.
//  Copyright © 2020 newbie. All rights reserved.
//

#ifndef BlockTest_h
#define BlockTest_h
#import <Foundation/Foundation.h>
#import <Foundation/NSException.h>


typedef int(^sumblock)(int val1 , int val2);
void useBlock(sumblock a);
void helloOCBlock(void);
volatile void exceptionHandler(NSException *exception);
extern NSUncaughtExceptionHandler *exceptionHandlerPtr;

#endif /* BlockTest_h */
