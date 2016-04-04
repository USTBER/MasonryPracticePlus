//
//  BaseViewController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/3/31.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "LCHBaseController.h"

@interface LCHBaseController ()

@end

@implementation LCHBaseController

- (id)initWithTitle:(NSString *)title{
    
    self = [super init];
    if(self){
        self.title = title;
    }
    return self;
}

- (id)init{
    
    return [self initWithTitle:@"暂未命名"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

@end
