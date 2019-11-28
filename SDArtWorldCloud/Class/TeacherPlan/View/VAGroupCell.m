//
//  VAGroupCell.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/28.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAGroupCell.h"

@interface VAGroupCell()
@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)UIImageView *imageView3;
@property(nonatomic,strong)UIImageView *imageView4;
@property(nonatomic,strong)UIView *groupBackView;
@property(nonatomic,strong)UILabel *groupTitle;
@end

@implementation VAGroupCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGroupView];
    }
    return self;
}
-(void)initGroupView{
    self.groupBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width , self.width)];
    [self addSubview:self.groupBackView];
    int count = 2;//一行2个icon
    CGFloat iconWidth = (self.groupBackView.width - 10)/count;
    CGFloat iconHeight = iconWidth;
    for (int i =0; i < 4; i++) {
        UIImageView *image = [[UIImageView alloc]init];
        image.backgroundColor = VAGrayUnUseColor;
        KClipsCornerRadius(image, 3);
        image.tag = i;
        CGFloat x = 0;
        CGFloat y = 0;
               if (i < count) {
                   x = i*(iconWidth + 5);
               }
               else{
                   x = (i-count)*(iconWidth + 5);
                   y = iconWidth + 5;
               }
        image.frame = CGRectMake(x, y, iconWidth, iconHeight);
        [self.groupBackView addSubview:image];
    }
    self.groupTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, self.groupBackView.height, self.groupBackView.width, 20)];
    self.groupTitle.text = @"分组标题";
    self.groupTitle.textAlignment = NSTextAlignmentCenter;
    self.groupTitle.textColor = VAMainTitleColor;
    self.groupTitle.font = VASubBlodTitleFont;
    [self addSubview:self.groupTitle];
}

@end
