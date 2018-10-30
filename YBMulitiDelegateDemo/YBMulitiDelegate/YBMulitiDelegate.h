//
//  YBMulitiDelegate.h
//  DemoTest
//
//  Created by 王迎博 on 2018/10/30.
//  Copyright © 2018年 王颖博. All rights reserved.
//
//  多播代理

#import <Foundation/Foundation.h>

@interface YBMulitiDelegate : NSProxy

/**
 创建
 @return MulitiDelegate对象
 */
+ (instancetype)factory;

/**
 添加代理
 */
- (void)addDelegate:(id)delegate;

/**
 移除代理
 */
- (void)removeDelete:(id)delegate;

- (void)removeAll;

@end
