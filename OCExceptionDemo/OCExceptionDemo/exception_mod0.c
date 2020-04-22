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


__attribute__ ((visibility("default"))) float test_mode(int i,int mod){
    float ret = i*1.0/mod;
    printf("c test_mode %d/%d = %f\n",i,mod,ret);
    int* a = malloc(sizeof(int));
    
    *a = 1;
    printf("use null point:%d" ,&a);
    free(a);
    free(a);	
    return ret;
   
}
