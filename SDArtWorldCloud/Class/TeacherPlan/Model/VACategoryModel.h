//
//  VACategoryModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VACategoryModel : NSObject

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *parent_id;

@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
