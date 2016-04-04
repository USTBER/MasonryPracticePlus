//
//  AspectFitConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "AspectFitConstrainsController.h"

@interface AspectFitConstrainsController ()

@property (nonatomic, strong) UIView *redUpView;
@property (nonatomic, strong) UIView *blueUpInsetView;
@property (nonatomic, strong) UIView *greenDownView;
@property (nonatomic, strong) UIView *yellowDownInsetView;

@end

static CGFloat const rate = 3.0f;
static CGFloat const padding = 20.f;

@implementation AspectFitConstrainsController

- (UIView *)redUpView{
    
    LazyLoad(_redUpView);
    _redUpView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redUpView];
    WeakSelf(weakSelf);
    [_redUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(weakSelf.view).offset(padding);
        make.right.mas_equalTo(weakSelf.view).offset(-padding);
        make.bottom.mas_equalTo(self.greenDownView.mas_top).offset(-padding);
    }];
    return _redUpView;
}

- (UIView *)blueUpInsetView{
    
    LazyLoad(_blueUpInsetView);
    _blueUpInsetView.backgroundColor = [UIColor blueColor];
    [self.redUpView addSubview:_blueUpInsetView];
    WeakSelf(weakSelf);
    [_blueUpInsetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.centerY.equalTo(weakSelf.redUpView);
    }];
    return _blueUpInsetView;
}

- (UIView *)greenDownView{
    
    LazyLoad(_greenDownView);
    _greenDownView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_greenDownView];
    WeakSelf(weakSelf);
    [_greenDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(padding);
        make.bottom.and.right.mas_equalTo(weakSelf.view).offset(-padding);
    }];
    return _greenDownView;
}

- (UIView *)yellowDownInsetView{
    
    LazyLoad(_yellowDownInsetView);
    _yellowDownInsetView.backgroundColor = [UIColor yellowColor];
    [self.greenDownView addSubview:_yellowDownInsetView];
    WeakSelf(weakSelf);
    [_yellowDownInsetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.centerX.equalTo(weakSelf.greenDownView);
    }];
    return _yellowDownInsetView;
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.redUpView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.greenDownView);
    }];
    [self.blueUpInsetView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.blueUpInsetView.mas_height).multipliedBy(rate).priorityLow();
    }];
    [self.yellowDownInsetView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.yellowDownInsetView.mas_width).multipliedBy(rate).priorityLow();
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
