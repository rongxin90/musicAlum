//
//  GRXCollectionCell.m
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import "GRXCollectionCell.h"
#import "UIImage+Radius.h"

@interface GRXCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation GRXCollectionCell


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setSubViews];
}


//设置子控件内容
- (void)setSubViews{
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    
    UIImage *image = [UIImage imageNamed:@"icon"];
    
    self.iconImage.image = [UIImage grx_radiusWithImage:image];
}


@end
