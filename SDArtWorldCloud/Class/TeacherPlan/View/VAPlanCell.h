//
//  VAPlanCell.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VACalendarCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VAPlanCell : UITableViewCell
@property(nonatomic,strong)VACalendarCourseModel *courseModel;
@end

NS_ASSUME_NONNULL_END
