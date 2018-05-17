//
//  NEPerson.m
//  NERuntimePractice
//
//  Created by N3210 on 2018/5/16.
//  Copyright © 2018年 N3210. All rights reserved.
//

#import "NEPerson.h"
#import <objc/message.h>
#import "NEDynamticObject.h"

@implementation NEPerson
#pragma mark - runtime
void dynamicAddtionMethodIMP(id self,SEL _cmd){
    NSLog(@"dynamicAddtionMethodIMP");
}

//+(BOOL) resolveInstanceMethod:(SEL)sel{
//     NSLog(@"resolveInstanceMethod: %@", NSStringFromSelector(sel));
//    if (sel ==@selector(appendString:)) {
//        class_addMethod([self class], sel, (IMP)dynamicAddtionMethodIMP, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    NSLog(@"resolveClassMethod %@",NSStringFromSelector(sel));
//    return [super resolveClassMethod:sel];
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSLog(@"forwardingTargetForSelector %@",NSStringFromSelector(aSelector));
//    if (aSelector ==@selector(appendString:)) {
//        return [[NEDynamticObject alloc]init];
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"methodSignatureForSelector:%@",NSStringFromSelector(aSelector));
//    NSMethodSignature *methodSignature=[NEDynamticObject methodSignatureForSelector:aSelector];
//    NSMethodSignature *methodSignature= [super methodSignatureForSelector:aSelector];
//    if (!methodSignature) {
//        [methodSignature methodSignatureForSelector:"v@:*"];
//    }
//    return methodSignature;
    NSString *selString =NSStringFromSelector(aSelector);
    if ([selString isEqualToString:@"appendString:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"methodSignatureForSelector:%@",anInvocation);
    NEDynamticObject *message= [NEDynamticObject new];
    if ([message respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:message];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

#pragma mark - kvo
- (void)showMySelf{
    NSLog(@"name:%@ age:%ld idNumber:%@",self.name,self.age,self.idNumber);
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"idNumber"];
    }
}
@end
