//
//  CLTagUICongfig.h
//  CLTagVeiw
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CLTagViewSingleType,    //单选
    CLTagViewDoubleType,    // 多选
} CLTagViewType;


@interface CLTagUICongfig : NSObject

// 标签背景色
@property (nonatomic, strong) UIColor *tagBackGroundColor;
/**
 *  标签边缘色彩
 */
@property (nonatomic, strong) UIColor *tagBorderColor;

/**
 *  标签选中边缘色彩  
 */
@property (nonatomic, strong) UIColor *tagSelectBorderColor;

/**
 *  字体颜色
 */
@property (nonatomic, strong) UIColor *tagColor;

/**
 *  标签选中字体颜色
 */
@property (nonatomic, strong) UIColor *tagSelectColor;




//  ===================

    // 布局相关
/**
 *  标签半径
 */
@property (nonatomic, assign) CGFloat tagCornerRadius;

// 每个标签的高度
@property (nonatomic, assign) CGFloat everyTagContentHeight;


@property (nonatomic, assign) CGFloat topMargin;

@property (nonatomic, assign) CGFloat leftMargin;

@property (nonatomic, assign) CGFloat bottomMargin;

@property (nonatomic, assign) CGFloat rightMargin;

@property (nonatomic, assign) CGFloat HSpace;

@property (nonatomic, assign) CGFloat VSpace;

// 为了让 标签看起来 宽松一些 设置的 文字距离label两边的距离总和
@property (nonatomic, assign) CGFloat textSpace;

@property (nonatomic, assign) CGFloat textSize;
// 默认单选
@property (nonatomic, assign)CLTagViewType selectType;
@end
