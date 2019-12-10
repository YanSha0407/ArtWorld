//
//  VAPictureListController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPictureGroupListController.h"
#import "VAMSQPictureListController.h"
@interface VAPictureGroupListController ()

@end

@implementation VAPictureGroupListController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self.groupModel.admin_id isEqualToString:[VAAccountManager getAccount].admin_id]) {
        self.isShowAddPictureBtn = YES;
//    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        // 添加图片
        [self showRadioSelectionDialogViewController];
    }
    else{
        // 查看大图
    }
}

#pragma mark ---选择图片来源
- (void)showRadioSelectionDialogViewController{
    QMUIOrderedDictionary *citys = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                                    @"拍摄",@"拍摄",
                                    @"从手机相册选择",@"从手机相册选择",
                                    @"我的素材库",@"我的素材库",
                                    @"校园素材库",@"校园素材库",
                                    @"美术圈图库",@"美术圈图库",
                                    nil];
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    dialogViewController.title = @"选择图片来源";
    dialogViewController.items = citys.allKeys;
    dialogViewController.rowHeight = 56;
    dialogViewController.titleLabelTextColor = VAMainTitleColor;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        QMUIDialogSelectionViewController *d = (QMUIDialogSelectionViewController *)aDialogViewController;
        if (d.selectedItemIndex == QMUIDialogSelectionViewControllerSelectedItemIndexNone) {
            [QMUITips showError:@"请至少选一个" inView:d.qmui_modalPresentationViewController.view hideAfterDelay:1.2];
            return;
        }
        NSString *city = d.items[d.selectedItemIndex];
        NSString *resultString = (NSString *)[citys objectForKey:city];
        weakify(self);
        [aDialogViewController hideWithAnimated:YES completion:^(BOOL finished) {
            strongify(self);
            [self clickPictureSource:resultString];
        }];
    }];
    [dialogViewController show];
}
-(void)clickPictureSource:(NSString *)result{
    if ([result isEqualToString:@"拍照"]) {
         
    }
    else if ([result isEqualToString:@"从手机相册选择"]){
        
    }
    else if ([result isEqualToString:@"我的素材库"]){
        
    }
    else if ([result isEqualToString:@"校园素材库"]){
        
    }
    else if ([result isEqualToString:@"美术圈图库"]){
        VAMSQPictureListController *pictureVC = [[VAMSQPictureListController alloc]init];
        pictureVC.title = @"美术圈图片";
        [self.navigationController pushViewController:pictureVC animated:YES];
    }
}
@end
