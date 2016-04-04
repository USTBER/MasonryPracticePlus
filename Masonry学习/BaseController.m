//
//  BaseController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/3/31.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *greenView;

@end

static int const padding = 10;

@implementation BaseController

- (UIView *)redView{
    
    if(_redView){
        return _redView;
    }
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    return _redView;
}

- (UIView *)blueView{
    
    if(_blueView){
        return _blueView;
    }
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    return _blueView;
}

- (UIView *)greenView{
    
    if(_greenView){
        return _greenView;
    }
    _greenView = [[UIView alloc] init];
    _greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_greenView];
    return _greenView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(padding);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(padding);
        make.right.mas_equalTo(weakSelf.blueView.mas_left).offset(-padding);
        make.bottom.equalTo(weakSelf.greenView.mas_top).offset(-padding);
        make.width.equalTo(weakSelf.blueView.mas_width);
        make.height.equalTo(@[weakSelf.blueView.mas_height, weakSelf.greenView.mas_height]);
    }];
    [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(padding);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-padding);
        
    }];
    [self.greenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-padding);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(padding);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-padding);
        
    }];
}

@end

