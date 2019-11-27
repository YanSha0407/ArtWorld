//
//  VAUserModel.h
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/10.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAUserModel : NSObject

@property (nonatomic, copy) NSString *admin_id;

@property (nonatomic, copy) NSString *campus_id;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *class_id;

@property (nonatomic, copy) NSString *is_all_visible;

@property (nonatomic, copy) NSString *user_role; // 角色 teacher   student   family
/// 头像URL
@property (nonatomic, strong) NSString *pic_url;

@property (nonatomic, copy) NSString *is_main;

@property (nonatomic, copy) NSString *name;
/// 备注名
@property (nonatomic, strong) NSString *remarkName;
/// 昵称
@property (nonatomic, strong) NSString *nikeName;

@property (nonatomic, strong) NSString *gender; // 性别

@property (nonatomic, strong) NSString *contact_phone;// 紧急联系人

@property (nonatomic, strong) NSString *campusId_Rn;// 校区ID

@property (nonatomic, strong) NSString *national_id;// 实名认证

@property (nonatomic, copy) NSString *phone_number;

@property (nonatomic, copy) NSString *studio_name; // 画室名称

@property (nonatomic, strong) NSString *province; //省份-可修改（关联省份id）

@property (nonatomic, strong) NSString *grade;// 年纪-可修改(10为高一 20为高二 30为高三)

@property (nonatomic, strong) NSString *school_name;// 学校名称-可修改

@property (nonatomic, copy) NSString *graduation_at; //毕业时间-可修改

@property (nonatomic, strong) NSString *total_score; //文化课总分-可修改

@property (nonatomic, strong) NSString *studio_id;// 校区id-不可修改

@property (nonatomic, copy) NSString *code_number; //激活码-不可修改

@property (nonatomic, copy) NSString *usersig; // 腾讯根据identifier生成usersig

@property (nonatomic, copy) NSString *identifier; // 腾讯生成usersig 唯一标识的依据

@property (nonatomic, copy) NSString *expert_category; // 擅长科目

@property (nonatomic, copy) NSString * relation_id; // 绑定学生的ID

@property (nonatomic, copy) NSString * student_name; // 绑定学生姓名

@property (nonatomic, copy) NSString * is_band;// 是否绑定学生

@property (nonatomic, copy) NSString * token_value; // Y用户Session

@property (assign, nonatomic) BOOL selected;

@property (assign, nonatomic) BOOL is_code_create; // 是否激活

@property (nonatomic, copy) NSString *is_vip; // 是否是会员  1是会员 0不是会员

@property (nonatomic, copy) NSString *vip_time; // vip到期时间

@property (nonatomic, copy) NSString *bind_code; // 绑定机构码

@property (nonatomic, copy) NSString *is_chat ; // 是否可以聊天

@property (nonatomic, copy) NSString *is_create;// 是否可以创建课件

@end
