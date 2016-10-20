//
//  ViewController.m
//  CLTagVeiw
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CLTagView *tagVeiw = [[CLTagView alloc] initWithFrame:self.view.bounds tagsArray: @[@"标签1", @"标签2", @"标签3", @"标签4", @"标签5", @"标签6", @"标签7", @"标签8", @"标签9", @"标签10", @"标签11", @"标签12"]
config:nil didSelectItemHandler:^( NSMutableArray *selectTags) {
   
    NSLog(@"%@",[selectTags firstObject]);
    
}];
    self.tagVeiw = tagVeiw;
  
    [self.view addSubview:self.tagVeiw];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
