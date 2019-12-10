//
//  VAPictureModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/6.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VASizeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VAPictureModel : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *imageFilePath;

@property (nonatomic, copy) NSString *imageGroupID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pic_id;

@property (nonatomic, assign) BOOL is_Selected; //是否选中

@property (nonatomic, assign) NSInteger source; //图片来源  1、美术圈 2、本地相册 3、我的素材库

@property (nonatomic, strong) NSArray<VAPictureModel *> *pic_list;

@property (nonatomic, strong) VASizeModel *size;

//@property (nonatomic, strong) VAChapterModel *video_url; // 关联视频

@end

NS_ASSUME_NONNULL_END
