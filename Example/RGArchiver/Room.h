//
//  Room.h
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
NS_ASSUME_NONNULL_BEGIN

@interface Room : NSObject

@property(nonatomic,strong) User *user;

@property(nonatomic,assign) NSInteger number;



@end

NS_ASSUME_NONNULL_END
