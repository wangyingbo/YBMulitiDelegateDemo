//
//  ViewController.m
//  YBMulitiDelegateDemo
//
//  Created by fengbang on 2018/10/30.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "BackgroundManager.h"

@interface ViewController ()<YBMulitiManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [BackgroundManager addDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark - YBMulitiManagerDelegate
- (void)yb_reciveMessage:(id)sender completion:(void (^)(id))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor redColor];
    });
    
    completion(NSStringFromClass([self class]));
}
@end
