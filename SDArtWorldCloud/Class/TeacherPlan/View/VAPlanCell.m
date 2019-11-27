//
//  VAPlanCell.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPlanCell.h"
#import "UIColor+ColorChange.h"
@interface VAPlanCell()
@property(nonatomic,strong)UILabel *courseTime;
@property(nonatomic,strong)UILabel *courseName;
@property(nonatomic,strong)UILabel *courseSubName;
@property(nonatomic,strong)UILabel *coursePictureCount;
@property(nonatomic,strong)UILabel *courseVideoCount;
@end

@implementation VAPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.courseTime];
        [self.contentView addSubview:self.courseName];
        [self.contentView addSubview:self.courseSubName];
        [self.contentView addSubview:self.coursePictureCount];
        [self.contentView addSubview:self.courseVideoCount];
        [self.contentView layoutSubviews];
    }
    return self;
}
-(UILabel *)courseTime{
    if (!_courseTime) {
        _courseTime = [[UILabel alloc]init];
        _courseTime.text = @"8:30-11:30";
        _courseTime.textColor = VABlackColor;
        _courseTime.font = VAMainBlodTitleFont;
    }
    return _courseTime;
}
-(UILabel *)courseName{
    if (!_courseName) {
        _courseName = [[UILabel alloc]init];
        _courseName.text = @"课程标题";
        _courseName.textColor = VABlackColor;
        _courseName.font = VAMainBlodTitleFont;
    }
    return _courseName;
}
-(UILabel *)courseSubName{
    if (!_courseSubName) {
        _courseSubName = [[UILabel alloc]init];
        _courseSubName.text = @"课程副标题";
        _courseSubName.textColor = VAMainTitleColor;
        _courseSubName.font = VASubTitleFont;
    }
    return _courseSubName;
}
-(UILabel *)coursePictureCount{
    if (!_coursePictureCount) {
        _coursePictureCount = [[UILabel alloc]init];
        _coursePictureCount.text = @"图片总数";
        _coursePictureCount.textColor = VAMainTitleColor;
        _coursePictureCount.font = VASubTitleFont;
    }
    return _coursePictureCount;
}
-(UILabel *)courseVideoCount{
    if (!_courseVideoCount) {
        _courseVideoCount = [[UILabel alloc]init];
        _courseVideoCount.text = @"视频总数";
        _courseVideoCount.textColor = VAMainTitleColor;
        _courseVideoCount.font = VASubTitleFont;
    }
    return _courseVideoCount;
}

-(void)setCourseModel:(VACalendarCourseModel *)courseModel{
  _courseModel = courseModel;
  self.courseTime.text = [NSString stringWithFormat:@"%@ : %@ -- %@",self.courseModel.class_period_id.name,self.courseModel.class_period_id.started_at,self.courseModel.class_period_id.dismissed_at];
  self.courseSubName.text = self.courseModel.class_content;
  self.coursePictureCount.text = self.courseModel.instruction_method_id.name;
 
  if (self.courseModel.category_id.color) {
    self.courseTime.textColor = [UIColor colorWithHexString:self.courseModel.category_id.color];
  }
  else{
    self.courseTime.textColor = VAMainTitleColor;
  }
    if (self.courseModel.instruction_method_id.name.length == 0) {
        self.coursePictureCount.hidden = YES;
    }
    else{
        self.coursePictureCount.hidden = NO;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.courseTime.frame = CGRectMake(LeftAndRightMargin, 0, KSystemWidth - 2 *LeftAndRightMargin, self.contentView.height/3);
    self.courseName.frame = CGRectMake(LeftAndRightMargin, self.courseTime.bottom, self.courseTime.width, self.contentView.height/3);
//    self.courseSubName.frame = CGRectMake(LeftAndRightMargin, self.courseName.bottom, self.courseTime.width, self.contentView.height/4);
    self.coursePictureCount.frame = CGRectMake(LeftAndRightMargin, self.courseName.bottom, 120, self.contentView.height/3);
    self.courseVideoCount.frame = CGRectMake(self.coursePictureCount.right, self.coursePictureCount.top, 120, self.contentView.height/3);
    
}
@end
