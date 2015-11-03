//
//  LZMGlobal.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/3.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMGlobal.h"




//指向全局唯一的实例对象
static LZMGlobal *instance = nil;

@implementation LZMGlobal


//保证单例对象无论创建多少次，永远都只有一份，多线程下要保证只有一个线程可以创建成功
+ (instancetype) allocWithZone:(struct _NSZone *)zone{
    
    //该方法只会执行一次，所以可以保障只会创建一个实例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

//用于返回单例对象的实例
+ (instancetype)sharedglobal{
    
    return [[self alloc] init ];
}

//对象在copy的过程中也只会返回同一个实例
- (id)copy{
    
    return instance;
}

// 如果是MRC还需要实现跟对象引用计数相关的几个方法

#if !__has_feature(objc_arc)

- (oneway void)release{
    //甚么也不做
}

- (instancetype)autorelease{
    return instance;
}

- (instancetype)retain{
    return instance;
}

- (NSUInteger)retainCount{
    return 1;
}

#endif
@end


