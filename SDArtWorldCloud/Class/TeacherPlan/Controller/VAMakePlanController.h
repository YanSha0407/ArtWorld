//
//  VAMakePlanController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/27.
//  Copyright © 2019 Sudo. All rights reserved.
//  制作课件

#import "VABaseViewController.h"
#import "VACalendarCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VAMakePlanController : VABaseViewController
@property(nonatomic,strong)VACalendarCourseModel *courseModel; // 课程model
@property(nonatomic,strong)Classes *classModel;//班级model
@property(nonatomic,strong)NSString *planDate;//创建课件的日期
@end

NS_ASSUME_NONNULL_END
