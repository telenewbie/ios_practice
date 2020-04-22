//
//  fork_c.c
//  ProcessIOS
//
//  Created by newbie on 2020/4/9.
//  Copyright © 2020 newbie. All rights reserved.
//

#include "fork_c.h"
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
// 传入函数指针，方便外部的调用
// 创建管道 进行消息通讯
#define BUF_SIZE 20

void* readFd (void* fd){
    char buf[BUF_SIZE];
    while(1){
        size_t n =write(((int*)fd)[1],buf, BUF_SIZE);
        
        printf("read over:%lu\n",n);
        sleep(1);
    }
    return NULL;
}

void createProcess_c(){
    int fildes[2] ={0};
    int ret = pipe(fildes);
    if(ret <0){
        printf("创建pipe 失败\n");
        return;
    }
//    pthread_t   pt;
//    pthread_create(&pt,NULL,readFd,fildes);
//    sleep(1);
//    close(fildes[0]);
//    close(fildes[1]);
//    printf("over\n");
    
#if 1
    
    pid_t pid  = fork();
    if(pid == 0){
        // 子进程
        printf("hello child\n");
        //关闭读端
        close(fildes[1]);
        // 每隔1s 往管道里面写入一句话
        while(1){
            const char* str = "hello child";
            printf("write begin\n");
            size_t n = read(fildes[0], str, strlen(str)+1);
            perror("write over");
            //if(n<0)
            {
                printf("write eof \n");
                exit(1);
            }
            sleep(1);
        }
    }else{
        // 主进程
        printf("hello parent\n");
        // 关闭写端
       
//        char buf[BUF_SIZE];
//        if(1){
//            read(fildes[0],buf, BUF_SIZE);
//            printf("read::%s\n",buf);
//            sleep(1);
//        }
        sleep(3);
         close(fildes[0]);
        close(fildes[1]);
        printf("main over \n");
    }
#endif
}
