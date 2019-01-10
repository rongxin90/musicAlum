//
//  GRXCollectionCell.h
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionItem;
NS_ASSUME_NONNULL_BEGIN

@interface GRXCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) CollectionItem *item;

@end

NS_ASSUME_NONNULL_END
