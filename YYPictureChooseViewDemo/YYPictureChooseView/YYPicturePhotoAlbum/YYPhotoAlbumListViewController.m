//
//  YYPhotoAlbumListViewController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureNavigationController.h"
#import "YYPhotoAlbumListViewController.h"
#import "YYPhotoAlbumDetailViewController.h"

@interface YYPhotoAlbumListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL needPushDetail;
@property (nonatomic, strong) NSArray<ALAssetsGroup *> *groupList;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YYPhotoAlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"相册";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(left_bar_button_clicked:)];
    
    
    [self.view addSubview:self.tableView];
    
    self.needPushDetail = YES;
    
    [YY_Navi.manager getGroupList:^(NSArray<ALAssetsGroup *> *result) {
        self.groupList = result;
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.needPushDetail) {
        self.needPushDetail = NO;
        
        YYPhotoAlbumDetailViewController *vc = [[YYPhotoAlbumDetailViewController alloc] initWithAssetsGroup:nil];
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)left_bar_button_clicked:(UIBarButtonItem *)barButtonItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YYPhotoAlbumDetailViewController *vc = [[YYPhotoAlbumDetailViewController alloc] initWithAssetsGroup:self.groupList[indexPath.item]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.imageView.image = [UIImage imageWithCGImage:[self.groupList[indexPath.row] posterImage]];
    cell.textLabel.text  = [NSString stringWithFormat:@"%@(%ld)", [self.groupList[indexPath.row] valueForProperty:ALAssetsGroupPropertyName], [self.groupList[indexPath.row] numberOfAssets]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark mark - getter/setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool"];
    }
    return _tableView;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
