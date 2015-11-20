//
//  ViewController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "ViewController.h"
#import "YYPictureChooseView.h"


@interface ViewController ()
@property (nonatomic, strong) YYPictureChooseView *chooseView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.chooseView = [[YYPictureChooseView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), (CGRectGetWidth(self.view.frame) - 5 * 10) / 4 * 2 + 30 + 1)];
    
    [self.view addSubview:self.chooseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
