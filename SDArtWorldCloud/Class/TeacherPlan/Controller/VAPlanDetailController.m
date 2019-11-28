//
//  VACourseDetailController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/27.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPlanDetailController.h"
#import "VAPictureGroupController.h"
#import "VAVideoGroupController.h"
@interface VAPlanDetailController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@end

@implementation VAPlanDetailController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listContainerView];
    self.navigationItem.titleView = self.categoryView;
}
-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
       _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, KSystemWidth, 50)];
       _categoryView.delegate = self;
        if ([[VAAccountManager getAccount].user_role isEqualToString:@"teacher"]) {
            _categoryView.titles = @[@"图片", @"视频",@"文字",@"作业"];
        }
        else{
            _categoryView.titles = @[@"图片", @"视频",@"文字"];
        }
        
       _categoryView.listContainer = self.listContainerView;
       _categoryView.titleColor = VAWhiteColor;
       _categoryView.titleSelectedColor = VAWhiteColor;
       _categoryView.titleFont = UIFontMake(16);
       _categoryView.titleSelectedFont = UIFontMake(18);
       _categoryView.titleColorGradientEnabled = YES;
       _categoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

#pragma mark - JXCategoryViewDelegate
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
      self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        VAPictureGroupController *pictureGroup = [[VAPictureGroupController alloc]init];
        return pictureGroup;
    }
    else if (index ==1){
        VAVideoGroupController *videoGroup = [[VAVideoGroupController alloc]init];
        return videoGroup;
    }
    else{
        return nil;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.listContainerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

@end
