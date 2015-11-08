//
//  LZMCommenCell.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMCommenCell.h"

@interface LZMCommenCell ()
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *textOfComment;
@property (nonatomic, strong) UIImageView *headImageOfComment;
@property (nonatomic, strong) UILabel *dateOfComment;
@property (nonatomic, assign) CGFloat cellWidth;
@end
@implementation LZMCommenCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellWidth = [UIScreen  mainScreen].bounds.size.width;
        [self layoutSubviews];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.headImageOfComment.frame = CGRectMake(12, 10, 40, 40);
    self.usernameLabel.frame = CGRectMake(12 + 60 + 9, 7, self.cellWidth - 24 - 60 - 18 - 100, 18);
    
    self.textOfComment.frame = CGRectMake(12 + 60 + 9, 30, self.cellWidth - 24 - 60 - 18, 18);
    
    self.dateOfComment.frame = CGRectMake(self.cellWidth - 90 - 24, 7, 90, 18);
    
}

- (void)setComment:(LZMCommentModel *)comment{
    _comment = comment;
    
    self.dateOfComment.text = comment.modified;
    self.textOfComment.text = comment.comment;
}


- (UILabel *)dateOfComment{
    if (!_dateOfComment) {
        _dateOfComment = [[UILabel alloc] init];
        _dateOfComment.textColor = [UIColor colorFromHexCode:@"9f9fa0"];
        _dateOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_dateOfComment];
    }
    return _dateOfComment;
}

- (UILabel *)textOfComment{
    if (!_textOfComment) {
        _textOfComment = [[UILabel alloc] init];
        _textOfComment.textColor = [UIColor colorFromHexCode:@"444444"];
        _textOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_textOfComment];
    }
    return _textOfComment;
}

- (UILabel *)usernameLabel{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.textColor = [UIColor colorFromHexCode:@"ee7f41"];
        _usernameLabel.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_usernameLabel];
    }
    return _usernameLabel;
}

- (UIImageView *)headImageOfComment{
    if (!_headImageOfComment) {
        _headImageOfComment = [[UIImageView alloc] init];
        _headImageOfComment.backgroundColor = [UIColor blueColor];
        _headImageOfComment.layer.cornerRadius = 20;
        _headImageOfComment.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImageOfComment];
    }
    return _headImageOfComment;
}



@end
