//
//  VAPictureListController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABasePictureListController.h"
#import "VAGroupModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VAPictureGroupListController : VABasePictureListController
@property (nonatomic,strong)VAGroupModel *groupModel;
@end

NS_ASSUME_NONNULL_END
