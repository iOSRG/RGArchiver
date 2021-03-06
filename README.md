# RGArchiver

[![CI Status](https://img.shields.io/travis/18607304107@163.com/RGArchiver.svg?style=flat)](https://travis-ci.org/18607304107@163.com/RGArchiver)
[![Version](https://img.shields.io/cocoapods/v/RGArchiver.svg?style=flat)](https://cocoapods.org/pods/RGArchiver)
[![License](https://img.shields.io/cocoapods/l/RGArchiver.svg?style=flat)](https://cocoapods.org/pods/RGArchiver)
[![Platform](https://img.shields.io/cocoapods/p/RGArchiver.svg?style=flat)](https://cocoapods.org/pods/RGArchiver)


轻量级OC对象本地缓存框架，无需手动继承`NSCoding`协议，也无需手动实现`NSCoding`协议里面的归档和解档方法

归档方法
```
+ (void)archiverObject:(id)object toFile:(NSString *)filePath;
```



解档方法

```
+ (id)unArchiverObjectOfObjectClass:(Class)cls fromFile:(NSString *)filePath;     
```

# 示例
```
- (IBAction)archiverUser:(id)sender {
    
    User *user = [User new];
    user.name = @"小明";
    user.age = 17;
    [RGArchiver archiverObject:user toFile:[self userPath]];

}

- (IBAction)unarchiverUser:(id)sender {
    
    User *user = [RGArchiver unArchiverObjectOfObjectClass:[User class] fromFile:[self userPath]];
    NSLog(@"age = %ld,name = %@",user.age,user.name);
    
}

- (NSString *)userPath {
    
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"user.plist"];
    NSLog(@"userPath = %@",path);
    return path;
}


```

如果对象中包含对象属性，只需将所包含的对象类进行参数传入即可
```
+ (void)archiverObject:(id)object toFile:(NSString *)filePath propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr;
```
```
+ (id)unArchiverObjectOfObjectClass:(Class)cls fromFile:(NSString *)filePath propertyObjectClass:(NSArray <Class>*)propertyObjectClassArr;
```

## Installation

RGArchiver is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RGArchiver'
```

如果pod失败，请先使用 `pod repo update`更新本地pod缓存库


