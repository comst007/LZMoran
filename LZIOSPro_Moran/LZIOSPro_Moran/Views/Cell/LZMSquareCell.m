//
//  LZMSquareCell.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMSquareCell.h"
#import "LZMSquareCollectionCell.h"
#import "LZMPictureModel.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation LZMSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZMSquareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionviewCell" forIndexPath:indexPath];
    
    LZMPictureModel *model = self.dataArr[indexPath.row];
    cell.titleLable.text = model.title;
    
    NSString *pic_url = model.pic_link;
    pic_url = [pic_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:pic_url];
    
    [cell.pictureImageView sd_setImageWithURL:URL];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LZMPictureModel *model = self.dataArr[indexPath.row];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.squareVC.pictureModel = model;
    
    [appDelegate.squareVC showDetailImage];
    //appDelegate.squareVC
    
    NSLog(@"%li", indexPath.row);
}


@end
