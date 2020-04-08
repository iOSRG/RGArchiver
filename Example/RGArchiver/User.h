//
//  User.h
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject <NSCoding>

@property(nonatomic,assign) NSInteger age;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *address;

@end

NS_ASSUME_NONNULL_END
