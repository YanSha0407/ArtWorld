//
//  VABaseGroupController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/28.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VABaseGroupController : VABaseViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,assign) CGRect rect;
@property (assign, nonatomic) NSInteger columnCount;
@property (strong, nonatomic) NSString *cellNibName;
@property (assign, nonatomic) BOOL isShowAddBtu;
@property (strong, nonatomic) NSMutableArray *groupMutableArray;
-(void)reloadCollectionData;
@end

NS_ASSUME_NONNULL_END
