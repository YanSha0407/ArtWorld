//
//  VAFilterModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/27.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAFilterModel : NSObject

@property (copy, nonatomic) NSString *itemId;

@property (copy, nonatomic) NSString *parent_id;

@property (copy, nonatomic) NSString *name;

@property (assign, nonatomic) NSInteger level;

@property (copy, nonatomic) NSString *type;

@property (copy, nonatomic) NSString *image;

@property (assign, nonatomic) NSInteger category_id;

@property (copy, nonatomic) NSString *priority;

@property (copy, nonatomic) NSString *create_time;

@property (copy, nonatomic) NSString *keyword_id;

@property (copy, nonatomic) NSString *status;

@property (assign, nonatomic) BOOL selected;

@end

NS_ASSUME_NONNULL_END
