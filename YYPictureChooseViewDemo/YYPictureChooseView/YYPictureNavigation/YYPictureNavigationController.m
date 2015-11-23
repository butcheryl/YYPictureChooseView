//
//  YYPictureNavigationController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureCaptureBottomView.h"
#import "YYPictureNavigationController.h"

@interface YYPictureNavigationController () <YYPictureCaptureBottomViewDelegate>
@property (nonatomic, strong) YYPictureCaptureBottomView *bottomView;
@end

@implementation YYPictureNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)submit_button_clicked {
    if (self.submit_click_block) {
        self.submit_click_block(self.manager.choosedAsset);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLastChoosedAsset:(NSArray<ALAsset *> *)lastChoosedAsset {
    _lastChoosedAsset = lastChoosedAsset;
    [self.manager settingChoosedAssets:self.lastChoosedAsset];
}

-(void)setManager:(YYPictureCoreManager *)manager {
    _manager = manager;
    
    self.bottomView = [[YYPictureCaptureBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 80, CGRectGetWidth(self.view.frame), 80)];
    self.bottomView.delegate = self;
    self.bottomView.manager = _manager;
    [self.view addSubview:self.bottomView];
}
@end
