//
//  VASubjectModel.h
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//  科目分类

#import <Foundation/Foundation.h>
#import "VAFilterModel.h"
@interface VASubjectModel : NSObject

@property (nonatomic, copy) NSString *request_param;

@property (nonatomic, assign) NSInteger choose_type;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<VAFilterModel *> *items;

@end
