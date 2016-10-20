//
//  CLTagVeiw.h
//  CLTagVeiw
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CLTagUICongfig;

@interface CLTagViewFlowLayout : UICollectionViewFlowLayout

@end




typedef void(^CLSelectItemHandler)(NSMutableArray *selectTags);

@interface CLTagView : UIView

@property (nonatomic, strong) NSArray *tags;  // 标签数组
@property (nonatomic, strong, readonly) NSMutableArray *selectTags;  // 只读的被选中的标签


/**
 *  block 接口
 *
 *  @param frame
 *  @param tags         标签数组
 *  @param config         配置
 *  @param handler      点击标签以后的处理事件
 *
 */
- (instancetype)initWithFrame:(CGRect)frame tagsArray:(NSArray *)tags config:(CLTagUICongfig *)config  didSelectItemHandler:(CLSelectItemHandler)handler;

@end
