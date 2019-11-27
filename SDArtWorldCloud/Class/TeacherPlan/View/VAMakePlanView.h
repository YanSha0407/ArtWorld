//
//  VAMakePlanView.h
//  CloudTeacherWebSite
//
//  Created by metis2017 on 2017/11/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chooseBlock)(NSInteger index);
@interface VAMakePlanView : UIView
@property (strong, nonatomic) NSMutableArray *btnMutableArray;// 上课形式数组
@property (nonatomic, strong) UIColor *btnBgColor;
@property (nonatomic, assign) CGSize heightSize;
@property (nonatomic, strong) UIView *ltView;
@property (nonatomic, strong) UIButton *btn;
@property(copy,nonatomic) chooseBlock block;
-(void)setChooseBlock:(chooseBlock)block;
- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)getArrayDataSourse:(NSArray *)array;
- (CGSize)returnSize;
@end
