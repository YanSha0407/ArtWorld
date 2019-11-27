//
//  UIColor+ColorChange.h
//  TeacherCloudSchool
//
//  Created by metis on 2017/8/15.
//  Copyright © 2017年 metis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
