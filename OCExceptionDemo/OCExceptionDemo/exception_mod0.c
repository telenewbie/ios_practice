//
//  exception_mod0.c
//  HelloObjectCApp
//
//  Created by newbie on 2020/4/21.
//  Copyright © 2020 newbie. All rights reserved.
//

#include "exception_mod0.h"
#include <execinfo.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/errno.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

void write_crash(const char * path ,const char* content,unsigned long  length){
    
    
    //创建目录
    if(access(path,F_OK) != 0)
    {
        char  dir[512]={0} ;
        for(size_t i = strlen(path);i!=0;--i)
        {
            if(path[i] == '/')
            {
                strncpy(dir,path,i);
                break;
            }
        }
        mkdir(dir,755);
    }
    
    
    
    // 开始写文件
    FILE* fp =fopen(path, "wb+");
    // 如果文件不存在就创建文件
    //FILE *fp = fopen(sFullFileName.c_str(), "ab+");
    //    printf("path!!!!!:%s\n",path);
    if(fp == NULL)
    {
        fprintf(stderr, "open file :%s\n", strerror(errno));
        return ;
    }
    
    size_t ret = fwrite((void*)content, 1, length, fp);
    fclose(fp);
    
    if(ret == length)
    {
        return ;
    }
    return;
}

#define BT_BUF_SIZE 100

void (*SIGHANDLE)(int) = NULL;
static const char* crash_path  = NULL;
void myhandler(int code)
{
    int j, nptrs;
    void *buffer[BT_BUF_SIZE];
    char **strings;
    nptrs = backtrace(buffer, BT_BUF_SIZE);
    printf("backtrace() returned %d addresses\n", nptrs);
    strings = backtrace_symbols(buffer, nptrs);
    if (strings == NULL)
    {
        perror("backtrace_symbols");
        exit(EXIT_FAILURE);
        return;
    }
    
    for (j = 0; j < nptrs; j++){
        printf("%s\n", strings[j]);
        write_crash(crash_path, strings[j], strlen(strings[j]));
    }
    
    free(strings);
    printf("over\n");
    
    
    //    SIGHANDLE(code);
}

__attribute__ ((visibility("default"))) float test_mode(const char * path,int i,int mod){
    crash_path = path;
    SIGHANDLE = signal(SIGSEGV, myhandler);
    signal(SIGHUP, myhandler);
    signal(SIGINT, myhandler);
    signal(SIGQUIT, myhandler);
    signal(SIGABRT, myhandler);
    signal(SIGILL, myhandler);
    signal(SIGSEGV, myhandler);
    signal(SIGFPE, myhandler);
    signal(SIGBUS, myhandler);
    signal(SIGPIPE, myhandler);
    
    float ret = i*1.0/mod;
    printf("c test_mode %d/%d = %f\n",i,mod,ret);
    int* a = malloc(sizeof(int));
    
    *a = 1;
    printf("use null point:%d" ,&a);
    free(a);
    free(a);
    return ret;
    
}
