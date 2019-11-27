//
//  VASubjectModel.m
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "VASubjectModel.h"

@implementation VASubjectModel
+ (NSDictionary *)mj_objectClassInArray{
  return @{@"items" : [VAFilterModel class]};
}
@end
