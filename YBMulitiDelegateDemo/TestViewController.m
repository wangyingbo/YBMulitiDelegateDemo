//
//  TestViewController.m
//  YBMulitiDelegateDemo
//
//  Created by fengbang on 2018/10/30.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "TestViewController.h"
#import "BackgroundManager.h"

@interface TestViewController ()<YBMulitiManagerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [BackgroundManager addDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%p",[YBMulitiDelegateManager sharedInstance]);
    NSLog(@"%p",[BackgroundManager sharedInstance]);
    
    [BackgroundManager sendMessage:nil completion:^(id obj) {
        NSLog(@"回调结果：%@",obj);
    }];
}

- (void)dealloc {
    [BackgroundManager removeManager];
    
    NSLog(@"%@ dealloc",[self class]);
}

#pragma mark - YBMulitiManagerDelegate
- (void)yb_reciveMessage:(id)sender completion:(void (^)(id))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor greenColor];
    });
    
    completion(NSStringFromClass([self class]));
}

@end
