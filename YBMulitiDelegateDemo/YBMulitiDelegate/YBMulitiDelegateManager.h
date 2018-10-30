//
//  YBMulitiDelegateManager.h
//  DemoTest
//
//  Created by fengbang on 2018/10/30.
//  Copyright © 2018年 王颖博. All rights reserved.
//
//  可被继承的单例

#import <Foundation/Foundation.h>

@protocol YBMulitiManagerDelegate <NSObject>
/**if wanna refresh UI,you must operation in the main thread*/
- (void)yb_reciveMessage:(_Nullable id)sender completion:(void(^)(id obj))completion;
@end

@interface YBMulitiDelegateManager : NSObject

+ (instancetype)sharedInstance;

/**
 单例-发消息

 @param data 参数
 @param completion 回调
 */
+ (void)sendMessage:(_Nullable id)data completion:(void(^)(id obj))completion;

/**
 清空所有代理
 */
+ (void)removeManager;

/**
 单例-添加单条代理

 @param delegate delegate description
 */
+ (void)addDelegate:(_Nonnull id<YBMulitiManagerDelegate>)delegate;

/**
 单例-移除单个代理

 @param delegate delegate description
 */
+ (void)removeDelegate:(_Nonnull id<YBMulitiManagerDelegate>)delegate;

@end
