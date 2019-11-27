//
//  VAAccountManager.h
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/10.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VAUserModel.h"
@interface VAAccountManager : NSObject
+ (void)saveAccountWithAccount:(VAUserModel *)account;
+ (VAUserModel *)getAccount;
+ (void)removeAccout;
@end
