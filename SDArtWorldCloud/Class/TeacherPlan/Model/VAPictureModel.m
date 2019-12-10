//
//  VAPictureModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/6.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPictureModel.h"

@implementation VAPictureModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
  return @{@"VASizeModel":@"size",@"YSChapterModel":@"video_url"};
}
+ (NSDictionary *)mj_objectClassInArray{
  return @{@"pic_list" : [VAPictureModel class]};
}
@end
