//
//  UncaughtExceptionHandler.m
//  HelloObjectCApp
//
//  Created by newbie on 2020/4/21.
//  Copyright © 2020 newbie. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UncaughtExceptionHandler.h"
@implementation UncaughtExceptionHandler

+(void)saveCreash:(NSString *)exceptionInfo
{
    NSString * _libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OCCrash"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSString * savePath = [_libPath stringByAppendingFormat:@"/error%@.log",timeString];
    
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"YES sucess:%d",sucess);
}

@end

static NSUncaughtExceptionHandler *previousUncaughtExceptionHandler;
void HandleException(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    NSLog(@"%@", exceptionInfo);
    [UncaughtExceptionHandler saveCreash:exceptionInfo];
    if(previousUncaughtExceptionHandler){
        previousUncaughtExceptionHandler(exception);
    }
}

void InstallUncaughtExceptionHandler(void)
{
    previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&HandleException);
}
