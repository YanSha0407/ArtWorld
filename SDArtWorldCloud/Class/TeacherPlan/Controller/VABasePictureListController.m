//
//  VABasePictureListController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABasePictureListController.h"
#import "VAPictureCell.h"
@interface VABasePictureListController ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic, strong) UICollectionView *baseCollectionVC;
@property (assign, nonatomic) NSInteger cellWidth;
@property (assign, nonatomic) NSInteger cellHeight;
@end

@implementation VABasePictureListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.baseCollectionVC];
}
-(UICollectionView *)baseCollectionVC{
    if (!_baseCollectionVC) {
        self.cellNibName = @"VAPictureCell";
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        layout.minimumColumnSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        if (IS_IPAD) {
            layout.columnCount = 5;
        }
        else{
            layout.columnCount = 3;
        }
        self.cellWidth = (KSystemWidth -layout.sectionInset.left-layout.sectionInset.right-(layout.columnCount-1)*layout.minimumColumnSpacing) / layout.columnCount;
        self.cellHeight = self.cellWidth;
        _baseCollectionVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSystemWidth, KSystemHeight - NavigationContentTop - TabBarHeight) collectionViewLayout:layout];
        _baseCollectionVC.dataSource = self;
        _baseCollectionVC.delegate = self;
        _baseCollectionVC.showsVerticalScrollIndicator = NO;
        _baseCollectionVC.showsHorizontalScrollIndicator = NO;
        [_baseCollectionVC registerClass:[VAPictureCell class] forCellWithReuseIdentifier:self.cellNibName];
        _baseCollectionVC.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
             [self headerRefreshBegin];
        }];
        _baseCollectionVC.mj_footer=[MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
             [self footerRefreshBegin];
        }];
        _baseCollectionVC.backgroundColor = VAMainBgColor;
    }
    return _baseCollectionVC;
}
-(NSMutableArray *)groupMutableArray{
    if (!_groupMutableArray) {
        _groupMutableArray = [NSMutableArray array];
    }
    return _groupMutableArray;
}
#pragma mark----头部底部刷新
-(void)headerRefreshBegin{
  
}
-(void)footerRefreshBegin{
  
}
-(void)reloadCollectionData{
    [self.baseCollectionVC reloadData];
}
#pragma mark ---- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isShowAddPictureBtn) {
        if (self.groupMutableArray.count) {
            return self.groupMutableArray.count + 1;
        }else{
            return 10;
        }
    }
    else{
         if (self.groupMutableArray.count) {
             return self.groupMutableArray.count;
         }else{
             return 10;
         }
    }
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VAPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellNibName forIndexPath:indexPath];
    if (self.groupMutableArray.count) {
        pictureCell.pictureModel = self.groupMutableArray[indexPath.row];
    }
    return pictureCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   return CGSizeMake(self.cellWidth,self.cellHeight);
}
@end
