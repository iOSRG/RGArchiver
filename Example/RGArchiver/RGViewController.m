//
//  RGViewController.m
//  RGArchiver
//
//  Created by 18607304107@163.com on 04/08/2020.
//  Copyright (c) 2020 18607304107@163.com. All rights reserved.
//

#import "RGViewController.h"
#import "User.h"
#import "Room.h"
#import "RGArchiver.h"
@interface RGViewController ()

@end

@implementation RGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}



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

- (IBAction)archiverRoom:(id)sender {
    
    User *user = [User new];
    user.name = @"小红";
    user.age = 21;
    
    Room *room = [Room new];
    room.user = user;
    room.number = 20;
    [RGArchiver archiverObject:room toFile:[self roomPath] propertyObjectClass:@[[User class]]];
    
    
}


- (IBAction)unarchiverRoom:(id)sender {
    
     Room *room = [RGArchiver unArchiverObjectOfObjectClass:[Room class] fromFile:[self roomPath] propertyObjectClass:@[[User class]]];
    NSLog(@"number = %ld,user.age = %ld,user.name = %@",room.number,room.user.age,room.user.name);
}

- (NSString *)userPath {
    
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"user.plist"];
    NSLog(@"userPath = %@",path);
    return path;
}

- (NSString *)roomPath {
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"room.plist"];
    NSLog(@"roomPath = %@",path);
    return path;
}

@end
