//
//  NSObject+KeyValue.m
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//

#import "NSObject+KeyValue.h"
#import <Objc/runtime.h>

@implementation NSObject (KeyValue)

- (NSDictionary *)allKeyValue {
    if ([self class] == nil) return nil;
    NSMutableDictionary *allKeyValue = [NSMutableDictionary dictionary];
    [self getClassAllKeyValueToDic:allKeyValue class:[self class]];
    return allKeyValue;
}

- (void)getClassAllKeyValueToDic:(NSMutableDictionary *)dic class:(Class)cls{
    
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList(cls, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *name =  ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [dic setValue:[self valueForKey:key] forKey:key];
    }
    if (class_getSuperclass(cls) && class_getSuperclass(cls) != [NSObject class]) {
        [self getClassAllKeyValueToDic:dic class:class_getSuperclass(cls)];
    }
}


- (NSArray *)allIvarKeys {
    if ([self class] == nil) return nil;
    NSMutableArray *allKeys = [NSMutableArray array];
    [self getClassAllKeys:allKeys class:[self class]];
    return allKeys;
}

- (void)getClassAllKeys:(NSMutableArray *)arr class:(Class)cls{
    
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList(cls, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *name =  ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [arr addObject:key];
    }
    if (class_getSuperclass(cls) && class_getSuperclass(cls) != [NSObject class]) {
        [self getClassAllKeys:arr class:class_getSuperclass(cls)];
    }
}

@end
