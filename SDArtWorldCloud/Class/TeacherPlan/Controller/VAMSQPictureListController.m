//
//  VAMSQPictureListController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/6.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAMSQPictureListController.h"
#import "VAPictureModel.h"
@interface VAMSQPictureListController ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger limit;
@end

@implementation VAMSQPictureListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.limit = 30;
    [self getMSQPicture];
}
#pragma mark----头部底部刷新
-(void)headerRefreshBegin{
    self.page = 0;
    [self.groupMutableArray removeAllObjects];
    [self getMSQPicture];
}
-(void)footerRefreshBegin{
    self.page ++;
    [self getMSQPicture];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        // 查看大图
}

#pragma mark --获取美术圈图片
-(void)getMSQPicture{
    if (kIsNetwork) {
        NSDictionary *lastestDic=@{@"page":[NSNumber numberWithInteger:self.page],@"limit":[NSNumber numberWithInteger:self.limit],@"type":[NSNumber numberWithInteger:1]};
        [PPNetworkHelper GET:kGetPritureData parameters:lastestDic success:^(id responseObject) {
            NSArray *arr = [VAPictureModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.groupMutableArray addObjectsFromArray:arr];
            [self reloadCollectionData];
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        VANetWorkError
    }
}
@end
