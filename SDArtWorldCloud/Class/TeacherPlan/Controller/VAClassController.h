//
//  VAClassController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//  班级界面

#import "VABaseViewController.h"
@class Classes;
NS_ASSUME_NONNULL_BEGIN

@interface VAClassController : VABaseViewController
@property (nonatomic, strong) void (^clickSureBtnBlock)(Classes *classModel);
@end

NS_ASSUME_NONNULL_END
