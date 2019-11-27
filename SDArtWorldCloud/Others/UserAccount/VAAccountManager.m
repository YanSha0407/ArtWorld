//
//  VAAccountManager.m
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/10.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "VAAccountManager.h"

@implementation VAAccountManager
+ (void)saveAccountWithAccount:(VAUserModel * )account {
    [[NSUserDefaults standardUserDefaults] setObject:account.mj_keyValues.copy forKey:@"accoutDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (VAUserModel *)getAccount {
  VAUserModel *account;
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"accoutDict"];
    account = [VAUserModel mj_objectWithKeyValues:dict];
  return account;
}

+ (void)removeAccout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accoutDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
