//
//  LhsSingleton.h
//  flashlight
//
//  Created by luo on 16/5/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#ifndef LhsSingleton_h
#define LhsSingleton_h


//// .h接口文件     sharedInstance##name 是让前面HMSingletonH(name) 接收到的参数拼接起来
//#define LhsSingletonH(name)     + (instancetype)sharedInstance##name;
//
//// .m文件 实现方法
//
////***********************         如果是ARC         ***********************
//#if __has_feature(objc_arc)
//
//#define LhsSingletonM(name) \
//static id _instace; \
//\
//+ (id)allocWithZone:(struct _NSZone *)zone \
//{ \
//static dispatch_once_t onceToken; \
//dispatch_once(&onceToken, ^{ \
//_instace = [super allocWithZone:zone]; \
//}); \
//return _instace; \
//} \
//\
//+ (instancetype)sharedInstance##name \
//{ \
//static dispatch_once_t onceToken; \
//dispatch_once(&onceToken, ^{ \
//_instace = [[self alloc] init]; \
//}); \
//return _instace; \
//} \
//\
//- (id)copyWithZone:(NSZone *)zone \
//{ \
//return _instace; \
//}
//
//
//
//
////***********************         如果是非ARC            ***********************
//#else
//
//#define LhsSingletonM(name) \
//static id _instace; \
//\
//+ (id)allocWithZone:(struct _NSZone *)zone \
//{ \
//static dispatch_once_t onceToken; \
//dispatch_once(&onceToken, ^{ \
//_instace = [super allocWithZone:zone]; \
//}); \
//return _instace; \
//} \
//\
//+ (instancetype)sharedInstance##name \
//{ \
//static dispatch_once_t onceToken; \
//dispatch_once(&onceToken, ^{ \
//_instace = [[self alloc] init]; \
//}); \
//return _instace; \
//} \
//\
//- (id)copyWithZone:(NSZone *)zone \
//{ \
//return _instace; \
//} \
//\
//- (oneway void)release { } \
//- (id)retain { return self; } \
//- (NSUInteger)retainCount { return 1;} \
//- (id)autorelease { return self;}




#endif /* LhsSingleton_h */
