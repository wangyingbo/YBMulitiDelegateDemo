//
//  YBMulitiDelegateManager.m
//  DemoTest
//
//  Created by fengbang on 2018/10/30.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "YBMulitiDelegateManager.h"
#import <objc/runtime.h>
#import "YBMulitiDelegate.h"


@interface YBMulitiDelegateManager ()
@property ( nonatomic, strong) YBMulitiDelegate *delegateProxy;
@end


@implementation YBMulitiDelegateManager

+ (instancetype)sharedInstance {
    id instance = objc_getAssociatedObject(self, @"instance");
    if (!instance) {
        instance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"instance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    Class selfClass = [self class];
    return [selfClass sharedInstance] ;
}


#pragma mark - lazy
- (YBMulitiDelegate *)delegateProxy {
    if (!_delegateProxy) {
        _delegateProxy = [YBMulitiDelegate factory];
    }
    return _delegateProxy;
}

#pragma mark - public factory method
+ (void)addDelegate:(id<YBMulitiManagerDelegate>)delegate {
    [[YBMulitiDelegateManager sharedInstance] addDelegate:delegate];
}

+ (void)removeDelegate:(id<YBMulitiManagerDelegate>)delegate {
    [[YBMulitiDelegateManager sharedInstance] removeDelegate:delegate];
}

+ (void)sendMessage:(_Nullable id)data completion:(void (^)(id))completion {
    [[YBMulitiDelegateManager sharedInstance] sendMessage:data completion:completion];
}

+ (void)removeManager {
    //objc_removeAssociatedObjects会移除一个对象的所有关联对象，将该对象恢复成“原始”状态
    //objc_removeAssociatedObjects(self);
    
    objc_setAssociatedObject(self, @"instance", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[YBMulitiDelegateManager sharedInstance].delegateProxy removeAll];
    [YBMulitiDelegateManager sharedInstance].delegateProxy = nil;
}

#pragma mark - private instance method
- (void)sendMessage:(id)data completion:(void (^)(id))completion {
    [(id<YBMulitiManagerDelegate>)self.delegateProxy yb_reciveMessage:data completion:^(id obj) {
        !completion?:completion(obj);
    }];
}

- (void)addDelegate:(_Nonnull id<YBMulitiManagerDelegate>)delegate {
    [self.delegateProxy addDelegate:delegate];
}

- (void)removeDelegate:(_Nonnull id<YBMulitiManagerDelegate>)delegate {
    [self.delegateProxy removeDelete:delegate];
}

@end
