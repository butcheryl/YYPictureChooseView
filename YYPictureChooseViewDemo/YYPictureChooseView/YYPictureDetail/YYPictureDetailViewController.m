//
//  YYPictureDetailViewController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface YYPictureDetailViewController ()

@end

@implementation YYPictureDetailViewController
- (instancetype)initWithAsset:(ALAsset *)asset isMain:(BOOL)isMain {
    if (self = [super init]) {
        self.asset = asset;
        self.isMainPicture = isMain;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_button setImage:[UIImage imageNamed:@"album_back"] forState:UIControlStateNormal];
    [back_button sizeToFit];
    back_button.frame = CGRectMake(10, 0, back_button.frame.size.width + 20, 44);
    [back_button addTarget:self action:@selector(back_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back_button];
    
    UIButton *delete_button = [UIButton buttonWithType:UIButtonTypeCustom];
    delete_button.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 100, 0, 100, 44);
    [delete_button setTitle:@"删除" forState:UIControlStateNormal];
    [delete_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delete_button addTarget:self action:@selector(delete_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete_button];
    
    UIImageView *picture_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 88)];
    picture_view.image = [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullScreenImage];
    picture_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picture_view];
    
    UIButton *main_button = [UIButton buttonWithType:UIButtonTypeCustom];
    main_button.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame), 44);
    [main_button setTitle:_isMainPicture?@"主图":@"设为主图" forState:UIControlStateNormal];
    [main_button setTitleColor:[UIColor colorWithRed:250/255. green:214/255. blue:87/255. alpha:1] forState:UIControlStateNormal];
    if (!_isMainPicture) {
        [main_button addTarget:self action:@selector(main_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:main_button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back_button_clicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)delete_button_clicked:(UIButton *)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定要删除这张图片?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.deletePicktureBlock) {
                self.deletePicktureBlock();
            }
        }];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)main_button_clicked:(UIButton *)button {
    if (self.settingMainPicktureBlock) {
        self.settingMainPicktureBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
