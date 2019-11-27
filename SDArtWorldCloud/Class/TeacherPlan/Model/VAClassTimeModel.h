//
//  VAClassTimeModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/26.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAClassTimeModel : NSObject

@property (nonatomic, copy) NSString *started_at;

@property (nonatomic, copy) NSString *dismissed_at;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger class_period_id;

@property (nonatomic, assign) NSInteger position;

@end

NS_ASSUME_NONNULL_END
