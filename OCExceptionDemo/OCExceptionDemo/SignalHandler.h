//
//  SignalHandler.h
//  HelloObjectCApp
//
//  Created by newbie on 2020/4/21.
//  Copyright © 2020 newbie. All rights reserved.
//

#ifndef SignalHandler_h
#define SignalHandler_h

#import <Foundation/Foundation.h>

@interface SignalHandler : NSObject

+(void)saveCreash:(NSString *)exceptionInfo;

@end

void InstallSignalHandler(void);
#endif /* SignalHandler_h */
