//
//  VACalendarCourseModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VACategoryModel.h"
#import "VAClassModel.h"
#import "VAClassTimeModel.h"
@class InstructionMethod,Instructor;
NS_ASSUME_NONNULL_BEGIN

@interface VACalendarCourseModel : NSObject

@property (nonatomic, copy) NSString *class_content;

@property (nonatomic, strong) Instructor *instructor;

@property (nonatomic, strong) VACategoryModel *category_id;

//@property (nonatomic, strong) VACourseModel *course_material_id;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, assign) NSInteger admin_id;

@property (nonatomic, strong) InstructionMethod *instruction_method_id; // 上课形式

@property (nonatomic, copy) NSString *started_at;

@property (nonatomic, assign) NSInteger class_id;

@property (nonatomic, copy) NSString *ended_at;

@property (nonatomic, copy) NSString *class_emphasis;

@property (nonatomic, assign) NSInteger course_id;

@property (nonatomic, strong) Classes * classList;

@property (nonatomic, strong) VAClassTimeModel *class_period_id;

@end

@interface InstructionMethod : NSObject

@property (nonatomic, assign) NSInteger instruction_method_id;

@property (nonatomic, copy) NSString *name;

@end

@interface Instructor : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger instructor_id;

@end

NS_ASSUME_NONNULL_END
