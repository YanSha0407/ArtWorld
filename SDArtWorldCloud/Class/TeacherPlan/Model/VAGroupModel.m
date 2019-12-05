//
//  VAGroupModel.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAGroupModel.h"

@implementation VAGroupModel
+ (NSDictionary *)mj_objectClassInArray{
  return @{@"preview_more" : [VAPreviewModel class]};
}
@end
