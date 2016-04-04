//
//  NormalScrollConstrainController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/3.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "NormalScrollConstrainController.h"

@interface NormalScrollConstrainController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *button;

@end

static CGFloat const imageViewLength = 100;
static CGFloat const buttonHeight = 50;
static CGFloat const padding = 20;
static CGFloat viewPadding = 80;
static NSString *const testString = @"这里是提示信息，通常会比较长，可能会超过两行。为了适配6.0，我们需要指定preferredMaxLayoutWidth，但是要注意，此属性一旦设置，不是只在6.0上生效，任意版本的系统的都有作用，因此此值设置得一定要准备，否则计算结果会不正确。我们一定要注意，不能给tableview的tableHeaderView和tableFooterView添加约束，在6.0及其以下版本上会crash，其它版本没有!!!这里是提示信息，通常会比较长，可能会超过两行。为了适配6.0，我们需要指定preferredMaxLayoutWidth，但是要注意，此属性一旦设置，不是只在6.0上生效，任意版本的系统的都有作用，因此此值设置得一定要准备，否则计算结果会不正确。我们一定要注意，不能给tableview的tableHeaderView和tableFooterView添加约束，在6.0及其以下版本上会crash，其它版本没有!!!这里是提示信息，通常会比较长，可能会超过两行。为了适配6.0，我们需要指定preferredMaxLayoutWidth，但是要注意，此属性一旦设置，不是只在6.0上生效，任意版本的系统的都有作用，因此此值设置得一定要准备，否则计算结果会不正确。我们一定要注意，不能给tableview的tableHeaderView和tableFooterView添加约束，在6.0及其以下版本上会crash，其它版本没有";

@implementation NormalScrollConstrainController

- (UIScrollView *)scrollView{
    
    if(_scrollView){
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.bounces = NO;
    WeakSelf(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
        
    }];
    return _scrollView;
}

- (UIView *)headView{
    
    if(_headView){
        return _headView;
    }
    _headView = [[UIView alloc] init];
    _headView.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    
    return _headView;
}

- (UIImageView *)imageView{
    
    if(_imageView){
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.layer.cornerRadius = imageViewLength / 2;
    _imageView.layer.borderColor = [UIColor blackColor].CGColor;
    _imageView.layer.borderWidth = 1;
    [self.headView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(viewPadding);
        make.centerX.offset(0);
        make.width.and.height.mas_equalTo(imageViewLength);
    }];
    
    return _imageView;
    
}

- (UILabel *)tipLabel{
    if(_tipLabel){
        return _tipLabel;
    }
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.preferredMaxLayoutWidth = MAIN_WIDTH - padding * 2;
    _tipLabel.numberOfLines = 0;
    _tipLabel.text = testString;
    [self.headView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
    }];
    
    return _tipLabel;
}

- (UIButton *)button{
    if(_button){
        return _button;
    }
    _button = [[UIButton alloc] init];
    _button.backgroundColor = [UIColor blueColor];
    [_button setTitle:@"点我有惊喜" forState:UIControlStateNormal];
    _button.layer.cornerRadius = 6.f;
    [self.headView addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(imageViewLength);
    }];
    
    [self.tipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).offset(viewPadding);
    }];
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(weakSelf.tipLabel.mas_bottom).offset(viewPadding);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.button.mas_bottom).offset(viewPadding).priorityLow();
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
