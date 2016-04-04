//
//  LCHAutoHeightCell.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "LCHAutoHeightCell.h"
#import "PrefixHeader.pch"
#import <Masonry.h>
@interface LCHAutoHeightCell ()

@property (nonatomic, strong) UIImageView *greenView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *informationLabel;
@property (nonatomic, strong) UILabel *lineLable;

- (void)handleTap;
@end

static CGFloat const padding = 10;
static CGFloat const imageViewLength = 70;

@implementation LCHAutoHeightCell

- (UIImageView *)greenView{
    if(_greenView){
        return _greenView;
    }
    _greenView = [[UIImageView alloc] init];
    _greenView.layer.cornerRadius = 35.f;
    _greenView.layer.masksToBounds = YES;
    _greenView.layer.borderColor = [UIColor blackColor].CGColor;
    _greenView.layer.borderWidth = 2.f;
    _greenView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_greenView];
    return _greenView;
}

- (UILabel *)nameLabel{
    
    if(_nameLabel){
        return _nameLabel;
    }
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_nameLabel];
    return _nameLabel;
    
}

- (UILabel *)informationLabel{
    
    if(_informationLabel){
        return _informationLabel;
    }
    _informationLabel = [[UILabel alloc] init];
    _informationLabel.textAlignment = NSTextAlignmentCenter;
    _informationLabel.numberOfLines = 0;
    _informationLabel.font = [UIFont systemFontOfSize:16];
    _informationLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - imageViewLength - padding * 3;
    [self.contentView addSubview:_informationLabel];
    return _informationLabel;
    
}

- (UILabel *)lineLable{
    
    if(_lineLable){
        return _lineLable;
    }
    _lineLable = [[UILabel alloc] init];
    _lineLable.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLable];
    return _lineLable;
}

- (void)setPeople:(People *)people{
    
    _people = people;
    self.nameLabel.text = people.name;
    self.informationLabel.text = people.information;
    [self.contentView setNeedsUpdateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    WeakSelf(weakSelf);
    [self.greenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(padding);
        //        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).priorityLow();
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        make.size.mas_equalTo(CGSizeMake(imageViewLength, imageViewLength));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(weakSelf.greenView.mas_right).offset(padding);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-padding);
    }];
    
    [self.informationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(padding);
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-padding);
    }];
    
    [self.lineLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(padding);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-padding);
        make.top.mas_equalTo(weakSelf.informationLabel.mas_bottom).offset(padding);
    }];
    
}

+ (CGFloat)cellHeightWithPeople:(People *)p{
    
    LCHAutoHeightCell *cell = [[LCHAutoHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.people = p;
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.lineLable.frame);
}

- (void)handleTap{
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
