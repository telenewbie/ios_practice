//
//  BlockTest.m
//  ProcessIOS
//
//  Created by newbie on 2020/4/10.
//  Copyright © 2020 newbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockTest.h"
#import <RxCocoa/RxCocoa.h>
void helloOCBlock(){
    ^int (int count) {
      return count + 1;
    };
    int(^sum)(int val1 ,int val2)=^int (int val1,int val2) {
        return val1+val2;
    };
    int  value=sum(1,2);
    printf("result:%d\n",value);
}
void useBlock(sumblock a){
    int blockVal = a(1,2);
    printf("useBlock block val:%d\n",blockVal);
}
