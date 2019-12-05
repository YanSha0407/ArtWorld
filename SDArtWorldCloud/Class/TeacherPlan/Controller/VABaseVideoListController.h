//
//  VABaseVideoListController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VABaseVideoListController : VABaseViewController
@property(nonatomic,assign)CGRect rect;
@property (assign, nonatomic) NSInteger columnCount;
@property (strong, nonatomic) NSString *cellNibName;
@property (strong, nonatomic) NSMutableArray *groupMutableArray;
@end

NS_ASSUME_NONNULL_END
