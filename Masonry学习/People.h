//
//  People.h
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *information;

- (instancetype)initWithName:(NSString *)name information:(NSString *)information;
+ (instancetype)peopleWithName:(NSString *)name information:(NSString *)information;

@end
