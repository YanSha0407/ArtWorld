//
//  VAClassModel.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Classes;

@interface VAClassModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger campus_id;

@property (nonatomic, strong) NSArray<Classes *> *classes;

@end

@interface Classes : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger class_id;

@end

NS_ASSUME_NONNULL_END
