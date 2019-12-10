//
//  VABasePictureListController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VABasePictureListController : VABaseViewController
@property(nonatomic,assign)CGRect rect;
@property (assign, nonatomic) NSInteger columnCount;
@property (strong, nonatomic) NSString *cellNibName;
@property (strong, nonatomic) NSMutableArray *groupMutableArray;
@property (assign, nonatomic) BOOL isShowAddPictureBtn;
-(void)reloadCollectionData;
@end

NS_ASSUME_NONNULL_END
