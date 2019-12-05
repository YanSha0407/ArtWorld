//
//  VAGroupModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/12/5.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VAPreviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VAGroupModel : NSObject

@property (nonatomic, assign) NSInteger group_id;

@property (nonatomic, copy) NSString *preview;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *material_library_id;

@property (nonatomic, copy) NSString *course_material_id;

@property (nonatomic, copy) NSString *is_main;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *admin_id;

@property (nonatomic, assign) NSInteger is_public; //是否公开

@property (nonatomic, assign) BOOL is_Selected; // 是否选中

@property (nonatomic, strong) VAPreviewModel *preview_more;

@end

NS_ASSUME_NONNULL_END
