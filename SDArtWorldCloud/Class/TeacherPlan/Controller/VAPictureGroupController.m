//
//  VAPictureGroupController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/28.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPictureGroupController.h"
#import "VAPictureGroupListController.h"
#import "VAGroupModel.h"
@interface VAPictureGroupController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSString *groupName;
@end

@implementation VAPictureGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片分组";
    self.isShowAddBtu = YES;
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

#pragma UICollectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isShowAddBtu && indexPath.row == 0) {
        [self showReturnKeyDialogViewController];
    }
    else{
        VAPictureGroupListController *basePicture = [[VAPictureGroupListController alloc]init];
        basePicture.title = @"图片分组";
        [self.navigationController pushViewController:basePicture animated:YES];
    }
}
#pragma mark ---添加分组名称
- (void)showReturnKeyDialogViewController{
    QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
    dialogViewController.title = @"请输入分组名称";
    [dialogViewController addTextFieldWithTitle:nil configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        textField.placeholder = @"请输入分组名称...";
        textField.maximumTextLength = 20;
        [textField addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    dialogViewController.shouldManageTextFieldsReturnEventAutomatically = YES;// 让键盘的 Return 键也能触发确定按钮的事件。这个属性默认就是 YES，这里为写出来只是为了演示
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *dialogViewController) {
        [dialogViewController hide];
        [self addPictureGroup:self.groupName];
    }];
    [dialogViewController show];
}
-(void)textValueChange:(UITextField *)textfiled{
    self.groupName = textfiled.text;
}
-(void)addPictureGroup:(NSString *)name{
    if (kIsNetwork) {
        NSDictionary *dic = @{@"name":name,@"course_material_id":self.planModel.course_material_id,@"type":@"10"};
        [PPNetworkHelper POST:kCreatGroupData(@"course-material/create") parameters:dic success:^(id responseObject) {
            if ([responseObject[@"success"] integerValue] == 1) {
                VAGroupModel *groupModel = [VAGroupModel mj_objectWithKeyValues:responseObject[@"data"]];
                VAPictureGroupListController *basePicture = [[VAPictureGroupListController alloc]init];
                basePicture.groupModel = groupModel;
                basePicture.title = @"图片分组";
                [self.navigationController pushViewController:basePicture animated:YES];
                [self.groupMutableArray insertObject:groupModel atIndex:0];
                [self reloadCollectionData];
            }
        } failure:^(NSError *error) {
            [TLUIUtility showErrorHint:@"创建失败"];
        }];
    }
    else{
        VANetWorkError
    }
}
@end
