//
//  VAURLFile.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#ifndef VAURLFile_h
#define VAURLFile_h

#define YXHeaderResquest @"http://api.teacher.meishuquanyunxiao.com/v2/"
#define KUserLogin [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"admin/login-test"] //手机号登录

#pragma mark --- 备课、课程表
#define KGetCoursePlanData [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"course"] //获取课程表数据信息
#define kGetClassListData [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"campus"] //获取校区班级
#define kGetClassFormData [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"instruction-method/get-list"] //获取上课形式
#define kGetSubjectData [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"category/get-list"] //获取所属科目
#define kMakePlanData [NSString stringWithFormat:@"%@%@",YXHeaderResquest,@"course/create"] //创建课件
#endif /* VAURLFile_h */
