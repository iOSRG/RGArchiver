//
//  RGArchiver.m
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//

#import "RGArchiver.h"
#import <Objc/runtime.h>
#import "NSObject+KeyValue.h"

@implementation RGArchiver

+ (void)archiverObject:(id)object
                toFile:(NSString *)filePath
   propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr {
    
    
    for (Class class in propertyObjectClassArr) {
        SEL encodeSel = @selector(encodeWithCoder:);
        if (![class instancesRespondToSelector:encodeSel]) {
            Class originClass = [class class];
            [self replaceEncodeIMP:encodeSel forClass:originClass];
        }
    }
    [self archiverObject:object toFile:filePath];
    
}


+ (void)archiverObject:(id)object
                toFile:(NSString *)filePath{
    
    if ([object respondsToSelector:@selector(encodeWithCoder:)]) {
        [NSKeyedArchiver archiveRootObject:object toFile:filePath];
        return;
    }
    
    if (object == nil) return;
    Class originClass = [object class];
    SEL encodeSel = @selector(encodeWithCoder:);
    
    if ([objc_getAssociatedObject(originClass, encodeSel) boolValue]) {
        [NSKeyedArchiver archiveRootObject:object toFile:filePath];
        return;
    }
    [self replaceEncodeIMP:encodeSel forClass:originClass];
    objc_setAssociatedObject(originClass, encodeSel, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    
}

 + (id)unArchiverObjectOfObjectClass:(Class)cls
                            fromFile:(NSString *)filePath
                 propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr {

    for (Class class in propertyObjectClassArr) {
        SEL decodeSel = @selector(initWithCoder:);
        Class originClass = [class class];
        if (![originClass instancesRespondToSelector:decodeSel]) {
            [self replaceDecodeIMP:decodeSel forClass:originClass];
        }
    }
    return [self unArchiverObjectOfObjectClass:cls fromFile:filePath];

}

 + (id)unArchiverObjectOfObjectClass:(Class)cls
                            fromFile:(NSString *)filePath {
    
     if ([cls instancesRespondToSelector:@selector(initWithCoder:)]) {
         return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
     }
    if (cls == nil) return nil;
    Class originClass = [cls class];
    SEL decodeSel = @selector(initWithCoder:);
    if ([objc_getAssociatedObject(originClass, decodeSel) boolValue]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    [self replaceDecodeIMP:decodeSel forClass:originClass];
    objc_setAssociatedObject(originClass, decodeSel, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}



+ (void)replaceEncodeIMP:(SEL)encodeSel forClass:(Class)originClass {
    
    void(^encodeBlock)(id objcect, NSCoder *coder) = ^(id objcect, NSCoder *coder){
        NSDictionary *allKeyValue = [objcect allKeyValue];
        for (NSString *key in allKeyValue.allKeys) {
            [coder encodeObject:allKeyValue[key] forKey:key];
        }
    };
    class_replaceMethod(originClass, encodeSel, imp_implementationWithBlock(encodeBlock),"v@:@");
}

+ (void)replaceDecodeIMP:(SEL)decodeSel forClass:(Class)originClass {
    id(^decodeBlock)(id object, NSCoder *coder) = ^id(id object, NSCoder *coder){
        NSArray *keys = [object allIvarKeys];
        for (NSInteger i = 0; i < keys.count; i++) {
            NSString *key = keys[i];
            [object setValue:[coder decodeObjectForKey:key] forKey:key];
        }
        return object;
    };
    class_replaceMethod(originClass, decodeSel,imp_implementationWithBlock(decodeBlock),"@@:@");
}

@end
