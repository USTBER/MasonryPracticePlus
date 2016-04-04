//
//  CompositeConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "CompositeConstrainsController.h"

@interface CompositeConstrainsController ()

@property (nonatomic, copy) NSMutableArray *views;
@property (nonatomic, assign, getter = isNormal) BOOL normal;

- (UIColor *)randomColor;
- (void)handleTap;

@end

static NSInteger const viewCount = 5;

@implementation CompositeConstrainsController

- (NSMutableArray *)views{
    
    if(_views){
        return _views;
    }
    _views = [[NSMutableArray alloc] initWithCapacity:viewCount];
    for(int i = 0; i < viewCount; i++){
        UIView *view = [[UIView alloc] init];
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 1;
        view.backgroundColor = [self randomColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [view addGestureRecognizer:tap];
        [self.view addSubview:view];
        [_views addObject:view];
    }
    return _views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.normal = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    UIView *lastView = weakSelf.view;
    if(self.isNormal){
        for(NSInteger i = self.views.count - 1; i>=0 ; i--){
            UIView *itemView = [self.views objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }else{
        for(NSInteger i = 0; i<self.views.count ; i++){
            UIView *itemView = [self.views objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }
}

- (void)handleTap{
    
    self.normal = !self.isNormal;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if(finished){
            
        }
    }];
}

- (UIColor *)randomColor{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat stauration = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:stauration brightness:brightness alpha:1];
}


@end
