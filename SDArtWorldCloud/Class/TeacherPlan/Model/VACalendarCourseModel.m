//
//  VACalendarCourseModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACalendarCourseModel.h"

@implementation VACalendarCourseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
  return @{@"YSCategoryModel":@"category_id",@"YSCourseModel":@"course_material_id",@"InstructionMethod":@"instruction_method_id",@"Classes":@"class_id",@"YSClassTimeModel":@"class_period_id"};
}
@end
@implementation InstructionMethod

@end

@implementation Instructor


@end
