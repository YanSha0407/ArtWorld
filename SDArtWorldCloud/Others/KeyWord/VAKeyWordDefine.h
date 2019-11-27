//
//  VAKeyWordDefine.h
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/7/11.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#ifndef VAKeyWordDefine_h
#define VAKeyWordDefine_h
#import <Foundation/Foundation.h>
// 制作课件 代表上课形式、所属科目
typedef NS_ENUM(NSInteger, VAMakePlanTextType) {
  VAMakePlanSubject = 1,
  VAMakePlanClassForm
};

#define     IS_IPHONEX_SAFEAREA     \
({   \
CGFloat a = 0.0 ; \
if (@available(iOS 11.0, *)) {      \
a = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;     \
}   \
a;  \
})\

#define VANotificationCenter [NSNotificationCenter defaultCenter]
#define KClipsCornerRadius(clipsView,radius) clipsView.layer.cornerRadius = radius;clipsView.clipsToBounds = YES
#define KSystemWidth  [UIScreen mainScreen].bounds.size.width
#define KSystemHeight [UIScreen mainScreen].bounds.size.height
#define NavigateHeight (KSystemWidth == 812.0 ? 88 : 64)
#define TabBarHeight (KSystemWidth == 812.0 ? 83 : 49)
// 左右边距
#define LeftAndRightMargin 20
/// URL
#define VAURL(urlString)     [NSURL URLWithString:urlString]
/// URL
#define VAImage(urlString)     [UIImage imageNamed:urlString]

#define weakify(var) __weak typeof(var) XYWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = XYWeak_##var; \
_Pragma("clang diagnostic pop")


#define KImageViewURl(imageView,url)  [imageView sd_setImageWithURL:VAURL(url) placeholderImage:[UIImage qmui_imageWithColor:VAGrayUnUseColor]];



#endif /* VAKeyWordDefine_h */
