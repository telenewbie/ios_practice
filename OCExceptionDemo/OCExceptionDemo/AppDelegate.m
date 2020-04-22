//
//  AppDelegate.m
//  HelloObjectCApp
//
//  Created by newbie on 2020/4/21.
//  Copyright © 2020 newbie. All rights reserved.
//

#import "AppDelegate.h"
#include <execinfo.h>
#include <signal.h>
#import "SignalHandler.h"
#import "UncaughtExceptionHandler.h"
#import "exception_mod0.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
///异常处理测试1
-(void)exceptionHandlerTest1{
    //1、ios崩溃【数组越界】
    NSArray *array= @[@"tom",@"xxx",@"ooo"];
    [array objectAtIndex:5];

}
///异常处理测试2
-(void)exceptionHandlerTest2{
    //2、用来制造一些异常【不存在string的方法】
    [self performSelector:@selector(string) withObject:nil afterDelay:2.0];
}

///异常处理测试3
-(void)exceptionHandlerTest3{
    //3、信号量
    int list[2]={1,2};
    int *p = list;
    //[奔溃位置]导致SIGABRT的错误，因为内存中根本就没有这个空间，哪来的free，就在栈中的对象而已
    free(p);
    p[1] = 5;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    InstallSignalHandler();
    InstallUncaughtExceptionHandler();
    
    //除 0 异常 不会崩溃
    int a = 1/0;
    
    NSLog(@"hello:::::%d",a);
//    test_mode(1, 0);
    //数组越界
    //// 定义数组
//    NSArray* arr = [NSArray arrayWithObjects:@"123", nil];
//    NSLog(@"count:%lu",(unsigned long)[arr count]);
//    NSLog(@"index2:%@",[arr objectAtIndex:1]);
    
        [self exceptionHandlerTest1];
    
//        [self exceptionHandlerTest2];

//        [self exceptionHandlerTest3];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
