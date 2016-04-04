//
//  LCHAutoHeightCell.h
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
@interface LCHAutoHeightCell : UITableViewCell

@property (nonatomic, strong) People *people;

+ (CGFloat)cellHeightWithPeople:(People *)p;

@end
