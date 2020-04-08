//
//  RGArchiver.h
//  RGArchiver_Example
//
//  Created by 浮生似梦、Dream on 2020/4/8.
//  Copyright © 2020 18607304107@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RGArchiver : NSObject

+ (void)archiverObject:(id)object
            toFile:(NSString *)filePath
   propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr;


+ (void)archiverObject:(id)object
            toFile:(NSString *)filePath;

+ (id)unArchiverObjectOfObjectClass:(Class)cls
                           fromFile:(NSString *)filePath;

+ (id)unArchiverObjectOfObjectClass:(Class)cls
                           fromFile:(NSString *)filePath
                propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr;

        

@end

NS_ASSUME_NONNULL_END
