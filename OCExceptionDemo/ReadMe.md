# 捕获异常
> Mach异常 和 Unix信号。
## 信号异常
```
#import <Foundation/Foundation.h>
#import "SignalHandler.h"
#include <execinfo.h>


void SignalExceptionHandler(int signal)
{
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    NSLog(@"%@", mstr);
   // [SignalHandler saveCreash:mstr];

}

void InstallSignalHandler(void)
{
    signal(SIGHUP, SignalExceptionHandler);
    signal(SIGINT, SignalExceptionHandler);
    signal(SIGQUIT, SignalExceptionHandler);
    
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

```
## 全局异常 
```
#import <Foundation/Foundation.h>
#import "UncaughtExceptionHandler.h"

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
    //[UncaughtExceptionHandler saveCreash:exceptionInfo];
}

void InstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
}

```

# XCode 中调试
[参考](https://blog.csdn.net/weixin_38633659/article/details/82496635)

需要使用模拟器调试信号 异常，默认情况下是隐藏的，所以这里有必要开启，才会捕获到crash信息
```
pro hand -p true -s false SIGABRT
```

# 异常分析
```
(lldb) pro hand -p true -s false SIGABRT
NAME         PASS   STOP   NOTIFY
===========  =====  =====  ======
SIGABRT      true   false  true 
c test_mode 1/0 = inf
use null point:-313145992HelloObjectCApp(3280,0x10bf37dc0) malloc: *** error for object 0x600002750050: pointer being freed was not allocated
HelloObjectCApp(3280,0x10bf37dc0) malloc: *** set a breakpoint in malloc_error_break to debug
2020-04-21 07:37:18.717131-0700 HelloObjectCApp[3280:82405] Stack:
0   HelloObjectCApp                     0x00000001026a2e47 SignalExceptionHandler + 103
1   libsystem_platform.dylib            0x00007fff51b9742d _sigtramp + 29
2   libsystem_c.dylib                   0x00007fff89c7d6e8 __sF + 152
3   libsystem_c.dylib                   0x00007fff51a8685c abort + 120
4   libsystem_malloc.dylib              0x00007fff51b82a63 _malloc_put + 0
5   libsystem_malloc.dylib              0x00007fff51b82c53 malloc_report + 151
6   HelloObjectCApp                     0x00000001026a31f6 test_mode + 150
7   HelloObjectCApp                     0x00000001026a28f4 -[AppDelegate application:didFinishLaunchingWithOptions:] + 116
```
## atos
[xcode debug下 生成 dysm 符号](https://blog.csdn.net/majiakun1/article/details/50725032)

[dysm 在哪里](https://www.jianshu.com/p/5ab21d6c0c22)

#### 在c 里面的异常尚未 成功获取到。

[计算atos 的地址方式，相减的方式](https://juejin.im/post/5cf769eb6fb9a07ea567dd9d)

待补充 ： 将信号的传递机制进行补充，现阶段是会 消费掉该线程，导致其他注册该信号捕获达不到效果


#### 本例中 
1. c层的双重释放 bug ，在 crash日志里面没有打印出具体行号，使用atos 之后也看不到实际的效果。

有人说： 因为 strip 的原因 ，毕竟在android里面一次会打出两个so 区别在于有无strip，方便快速定位问题。

使用到的工具有 ：`objdump -t OCExceptionDemoApp.app/OCExceptionDemoApp ` 以及 `strip OCExceptionDemoApp.app/OCExceptionDemoApp`  发现哪里有问题哦。


2.  我的疑问：如何查看保存在 文件里面的crash，模拟器上，手机上的文件管理器好像没有入口呢
 入口就在： `/Users/$USER_NAME/Library/Developer/CoreSimulator/Devices/$ID` 其中 USERNAME 为 用户名 ID为 打开XCode ` Window -> Devices and simulators ->iphone 11 pro max->$ID` 就在这里可以看到 
