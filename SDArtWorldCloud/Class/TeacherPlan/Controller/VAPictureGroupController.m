//
//  VAPictureGroupController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/28.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAPictureGroupController.h"

@interface VAPictureGroupController ()

@end

@implementation VAPictureGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片分组";
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
@end
