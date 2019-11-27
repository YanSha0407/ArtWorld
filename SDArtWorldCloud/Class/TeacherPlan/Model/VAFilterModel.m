//
//  VAFilterModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/27.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAFilterModel.h"

@implementation VAFilterModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
  return @{@"itemId":@"id"}; //,@"category_id":@"cclive_type" 直播CCType测试
}
@end
