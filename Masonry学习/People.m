//
//  People.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "People.h"

@implementation People

- (instancetype)initWithName:(NSString *)name information:(NSString *)information{
    self = [super init];
    if(self){
        _name = name;
        _information = information;
    }
    return self;
}

- (id)init{
    return [self initWithName:@"未命名" information:@"没有信息"];
}

+ (instancetype)peopleWithName:(NSString *)name information:(NSString *)information{
    
    People *p = [[People alloc] initWithName:name information:information];
    return p;
}


@end
