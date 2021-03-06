//
//  JCPresentingVC.m
//  JCTransitionExample
//
//  Created by chenjiangchuan on 16/6/16.
//  Copyright © 2016年 JC‘Chan. All rights reserved.
//

#import "JCPresentedVC.h"
#import "JCPresentingVC.h"
#import "JCTransitioningDelegate.h"

@interface JCPresentingVC ()

/** 负责告诉系统谁来负责自定义动画 */
@property (strong, nonatomic) JCTransitioningDelegate *transitionDelegate;

/** 转场后的控制器 */
@property (strong, nonatomic) JCPresentedVC *presentedVC;

/** 测试Label */
@property (strong, nonatomic) UILabel *testLabel;

@end

@implementation JCPresentingVC
// View生命周期相关的方法
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.testLabel];
}

/**
 *  改变控件的位置可以在这个方法或者
 *  viewDidLayoutSubviews中实现
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.testLabel.frame = (CGRect){{100, 100}, {200, 200}};
}

// 所有button,gestureRecognizer的响应事件都放在这个区域里面
#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.transitionDelegate jc_jumpToPresentingController];
}

// View的初始化都交给getter去做了
#pragma mark - getters and setters
- (JCTransitioningDelegate *)transitionDelegate {
    if (_transitionDelegate == nil) {

        _transitionDelegate = [JCTransitioningDelegate animatedTransitioningWithPresentingViewController:self presentedViewController:self.presentedVC withTransitionMode:JCTransitionModeAlpha];
    }
    return _transitionDelegate;
}

- (JCPresentedVC *)presentedVC {
    if (_presentedVC == nil) {
        _presentedVC = [[JCPresentedVC alloc] init];
    }
    return _presentedVC;
}

- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.text = @"转场前控制器";
    }
    return _testLabel;
}

@end
