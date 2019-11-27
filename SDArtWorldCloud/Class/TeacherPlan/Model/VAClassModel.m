//
//  VAClassModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAClassModel.h"

@implementation VAClassModel
MJExtensionCodingImplementation  // 宏实现
+ (NSDictionary *)mj_objectClassInArray{
  return @{@"classes" : [Classes class]};
}
@end

@implementation Classes
MJExtensionCodingImplementation  // 宏实现
@end

