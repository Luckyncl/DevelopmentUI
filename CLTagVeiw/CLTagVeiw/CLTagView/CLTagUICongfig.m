//
//  CLTagUICongfig.m
//  CLTagVeiw
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CLTagUICongfig.h"

@implementation CLTagUICongfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tagBackGroundColor = [UIColor clearColor];
        _tagBorderColor = [UIColor lightGrayColor];
        _tagSelectBorderColor = [UIColor colorWithRed:21/255.0 green:169/255.0 blue:188/255.0 alpha:1];
        _tagColor = [UIColor colorWithWhite:125.0/255.0 alpha:1.0f];
        _tagSelectColor = [UIColor colorWithRed:21/255.0 green:169/255.0 blue:188/255.0 alpha:1];
        
        _selectType = 1;
        
        
        _topMargin = 10.f;
        _leftMargin = 10.f;
        _rightMargin = 10.f;
        _bottomMargin = 10.f;
        
        _HSpace = 10.f;
        _VSpace = 10.f;
        
        _tagCornerRadius = 10.f;
        
        _everyTagContentHeight = 22.f;
        
        _textSpace = 20.f;
        
        _textSize = 14;
      
    }
    return self;
}



@end
