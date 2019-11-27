//
//  VACalendarModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACalendarModel.h"

@implementation VACalendarModel

+ (NSDictionary *)objectClassInArray{
  return @{@"course" : [VACalendarCourseModel class]};
}
@end
