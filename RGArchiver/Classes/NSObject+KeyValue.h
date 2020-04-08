//
//  NSObject+KeyValue.h
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KeyValue)

- (NSDictionary *)allKeyValue;
- (NSArray *)allIvarKeys;
- (void)getClassAllKeyValueToDic:(NSMutableDictionary *)dic class:(Class)cls;
- (void)getClassAllKeys:(NSMutableArray *)arr class:(Class)cls;

@end

NS_ASSUME_NONNULL_END
