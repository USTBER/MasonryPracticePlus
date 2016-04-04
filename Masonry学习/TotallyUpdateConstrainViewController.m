//
//  TotallyUpdateConstrainViewController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "TotallyUpdateConstrainViewController.h"

@interface TotallyUpdateConstrainViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, assign, getter=hasExpanded) BOOL expanded;
@property (nonatomic, assign) CGFloat redViewHeight;
@property (nonatomic, assign) CGFloat blueViewLength;

- (void)handleTap;
@end

static CGFloat const increment = 200;

@implementation TotallyUpdateConstrainViewController

- (UIView *)redView{
    
    if(_redView){
        return _redView;
    }
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.borderColor = [UIColor blackColor].CGColor;
    _redView.layer.borderWidth = 2.f;
    [self.view addSubview:_redView];
    WeakSelf(weakSelf);
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(20);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
//        make.height.mas_equalTo(weakSelf.redViewHeight);
    }];
    return _redView;
    
}

- (UIView *)blueView{
    
    if(_blueView){
        return _blueView;
    }
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = [UIColor blueColor];
    _blueView.layer.borderColor = [UIColor blackColor].CGColor;
    _blueView.layer.borderWidth = 2.f;
    [self.redView addSubview:_blueView];
    WeakSelf(weakSelf);
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.redView);
//        make.width.and.height.mas_equalTo(weakSelf.blueViewLength);
    }];
    return _blueView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redViewHeight = 500;
    self.blueViewLength = 90;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.redView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.redViewHeight);
    }];
    
    [self.blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(weakSelf.blueViewLength);
    }];
}

- (void)handleTap{
    
    if(self.hasExpanded){
        self.redViewHeight -= increment;
        self.blueViewLength = 90;
    }else{
        self.redViewHeight += increment;
        self.blueViewLength = 250;
    }
    self.expanded = !self.hasExpanded;
    
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
