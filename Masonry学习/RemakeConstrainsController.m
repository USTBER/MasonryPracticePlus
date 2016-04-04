//
//  RemakeConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/3/31.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "RemakeConstrainsController.h"

@interface RemakeConstrainsController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIButton *growingBtn;
@property (nonatomic, assign) CGFloat redViewHeight;
@property (nonatomic, assign, getter=isExpanded) BOOL expanded;

- (void)handleTap:(UIButton *)sender;
@end

@implementation RemakeConstrainsController

- (UIView *)redView{
    
    if(_redView){
        return _redView;
    }
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.borderColor = [UIColor greenColor].CGColor;
    _redView.layer.borderWidth = 2;
    [self.view addSubview:_redView];
    WeakSelf(weakSelf);
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.redViewHeight);
    }];
    return _redView;
}

- (UIButton *)growingBtn{
    
    if(_growingBtn){
        return _growingBtn;
    }
    _growingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_growingBtn setTitle:@"点我展开" forState:UIControlStateNormal];
    [self.redView addSubview:_growingBtn];
    __weak typeof(self.redView) weakRedView = self.redView;
    [_growingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakRedView);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    return _growingBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redViewHeight = 500;
    self.expanded = false;
    [self.growingBtn addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.redViewHeight);
        
    }];
}

- (void)handleTap:(UIButton *)sender{
    
    self.isExpanded ? (self.redViewHeight += 200, [self.growingBtn setTitle:@"点我缩回" forState:UIControlStateNormal]) : (self.redViewHeight -= 200, [self.growingBtn setTitle:@"点我展开" forState:UIControlStateNormal]);
    self.expanded = !self.isExpanded;
    
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.7 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}


@end
