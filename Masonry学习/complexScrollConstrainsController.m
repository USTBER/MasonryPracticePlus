//
//  complexScrollConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/3.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "complexScrollConstrainsController.h"

@interface complexScrollConstrainsController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *labels;
@property (nonatomic, copy) NSMutableArray *labelExpanded;

- (void)handleTap:(UITapGestureRecognizer *)sender;
- (NSString *)randomText;
- (UIColor *)randomColor;
@end

static CGFloat const padding = 15.f;
static NSUInteger const labelCount = 10;
static CGFloat const originHeight = 40.f;

@implementation complexScrollConstrainsController


- (UIScrollView *)scrollView{
    
    if(_scrollView){
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    _scrollView.bounces = YES;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    WeakSelf(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).offset(0);
    }];
    return _scrollView;
}

- (NSArray *)labels{
    
    if(_labels){
        return _labels;
    }
    NSMutableArray *temArr = [[NSMutableArray alloc] initWithCapacity:labelCount];
    __weak UILabel *lastLabel = nil;
    for(int i = 0; i < labelCount; i ++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.preferredMaxLayoutWidth = MAIN_WIDTH - padding * 2;
        label.layer.borderWidth = 2.f;
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.backgroundColor = [self randomColor];
        label.text = [self randomText];
        WeakSelf(weakSelf);
        [weakSelf.scrollView addSubview:label];
        [temArr addObject:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.scrollView.mas_left).offset(padding);
            make.right.mas_equalTo(weakSelf.scrollView.mas_right).offset(-padding);
            if(lastLabel){
                make.top.equalTo(lastLabel.mas_bottom).offset(padding);
            }else{
                make.top.mas_equalTo(weakSelf.scrollView.mas_top).offset(padding);
            }
            make.height.mas_equalTo(originHeight);
        }];
        lastLabel = label;
        _labels = [NSArray arrayWithArray:temArr];
    }
    return _labels;
}

- (NSArray *)labelExpanded{
    
    if(_labelExpanded){
        return _labelExpanded;
    }
    _labelExpanded = [[NSMutableArray alloc] initWithCapacity:labelCount];
    NSInteger num = labelCount;
    while (num) {
        [_labelExpanded addObject:[NSNumber numberWithBool:false]];
        num --;
    }
    return _labelExpanded;
}

- (void)handleTap:(UITapGestureRecognizer *)sender{
    
    UIView *tapLabel = sender.view;
    NSInteger tag = tapLabel.tag;

    NSNumber *expanded = [self.labelExpanded objectAtIndex:tag];
    expanded = [expanded boolValue] ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
    [self.labelExpanded replaceObjectAtIndex:tag withObject:expanded];
    UILabel *preLabel = nil;
    UILabel *nextLabel = nil;
    if(tag){
        preLabel = [self.labels objectAtIndex:tag - 1];
    }
    if(tag < labelCount - 1){
        nextLabel = [self.labels objectAtIndex:tag + 1];
    }
    
    if([expanded boolValue]){
        [tapLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(padding);
            make.right.mas_equalTo(-padding);
            
            if(preLabel){
                make.top.mas_equalTo(preLabel.mas_bottom).offset(padding);
            }else{
                make.top.mas_equalTo(padding);
            }
        }];
        
        if(nextLabel){
            [nextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(tapLabel.mas_bottom).offset(padding);
            }];
        }
    }else{
        [tapLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(originHeight);
        }];
    }

    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints{

    [super updateViewConstraints];
    __weak UILabel *lastLabel = [self.labels objectAtIndex:labelCount - 1];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(lastLabel){
            make.bottom.mas_equalTo(lastLabel.mas_bottom);
        }
    }];
}

- (NSString *)randomText{
    
    NSString *originString = @"这只是一个实验";
    NSInteger count = arc4random() % 6;
    while(count){
        originString = [originString stringByAppendingString:originString];
        count --;
    }
    return originString;
}

- (UIColor *)randomColor{
    
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return randomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
