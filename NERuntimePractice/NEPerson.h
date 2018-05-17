//
//  NEPerson.h
//  NERuntimePractice
//
//  Created by N3210 on 2018/5/16.
//  Copyright © 2018年 N3210. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEPerson : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSUInteger age;
@property(nonatomic, strong) NSString *idNumber;

- (void)showMySelf;
@end
