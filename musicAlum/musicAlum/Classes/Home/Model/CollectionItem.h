//
//  CollectionItem.h
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionItem : NSObject
//选中需要执行的操作
@property (copy, nonatomic)void(^action)();

@end

NS_ASSUME_NONNULL_END
