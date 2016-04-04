//
//  UpdateConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/3/31.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "UpdateConstrainsController.h"

@interface UpdateConstrainsController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) CGFloat scale;

- (void)handlePressWithButton:(UIButton *)sender;
@end

static CGFloat const originLength = 100;

@implementation UpdateConstrainsController

- (UIButton *)button{
    
    if(_button){
        return _button;
    }
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"PressMe" forState:UIControlStateNormal];
    _button.layer.borderColor = [UIColor greenColor].CGColor;
    _button.layer.borderWidth = 2;
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(handlePressWithButton:) forControlEvents:UIControlEventTouchUpInside];
    WeakSelf(weakSelf);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
//        make.width.and.height.mas_equalTo(originLength * weakSelf.scale).priorityLow();
        make.width.and.height.lessThanOrEqualTo(weakSelf.view);
    }];
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scale = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(originLength * weakSelf.scale).priorityLow();
//        make.width.and.height.lessThanOrEqualTo(weakSelf.view);
    }];
}

- (void)handlePressWithButton:(UIButton *)sender{
    
    self.scale += 0.2;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
};



@end
