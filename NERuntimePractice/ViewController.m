//
//  ViewController.m
//  NERuntimePractice
//
//  Created by N3210 on 2018/5/16.
//  Copyright © 2018年 N3210. All rights reserved.
//

#import "ViewController.h"
#import "NEPerson.h"
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id person =[NEPerson new];
    [person appendString:@""];
    
//    [self testMeta];
    
//    [self testProperty];
//    [self testKVO];
}

- (void)testKVO{
    NSDictionary *dict = @{@"name": @"Jiaming Chen", @"age": @20, @"id": @"1603121434"};
    NEPerson *person =[NEPerson new];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [person setValue:obj forKey:key];
    }];
    
    [person showMySelf];
}

- (void)testMeta{
    NEPerson *p = [[NEPerson alloc] init];
    Class c1 = [p class];
    Class c2 = [NEPerson class];
    //输出 1
    NSLog(@"%d", c1 == c2);
    
    //输出1
    NSLog(@"%d", [p class] == object_getClass(p));
    //输出0
    NSLog(@"%d", class_isMetaClass(object_getClass(p)));
    //输出1
    NSLog(@"%d", class_isMetaClass(object_getClass([NEPerson class])));
    //输出0
    NSLog(@"%d", object_getClass(p) == object_getClass([NEPerson class]));
}

- (void)testProperty{
    NEPerson *p=[NEPerson new];
    p.name=@"sdf";
    p.age=21;
    unsigned int propertyCount=0;
    objc_property_t *propertyList= class_copyPropertyList([p class], &propertyCount);
    for (NSInteger index=0; index<propertyCount; index++) {
        const char *name= property_getName(propertyList[index]);
        const char *attributes=property_getAttributes(propertyList[index]);
        NSLog(@"%s %s",name,attributes);
    }
    
    objc_property_attribute_t attributes = {
        "T@\"NSString\",C,N,V_studentIdentifier",
        "",
    };
    class_addProperty([p class], "studentIdentifier", &attributes, 1);
    objc_property_t property = class_getProperty([p class], "studentIdentifier");
    NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
