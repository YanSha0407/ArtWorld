//
//  VACalendarModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACalendarCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VACalendarModel : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger is_my_course;// 1有  0没有

@property (nonatomic, strong) NSArray<VACalendarCourseModel *> *course;

@end

NS_ASSUME_NONNULL_END
