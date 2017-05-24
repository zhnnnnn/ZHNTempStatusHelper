//
//  ZHNMethodSwizzingHelper.h
//  ZHNNaviBarHelper
//
//  Created by zhn on 2017/3/9.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#define zhn_dispatch_once(onceBlock) static dispatch_once_t onceToken;\
dispatch_once(&onceToken, onceBlock);\

@interface ZHNMethodSwizzingHelper : NSObject
/**
 方法交换

 @param swizzingClass 类
 @param originalSEL 旧方法
 @param newSEL 新方法
 */
+ (void)swizzinClass:(Class)swizzingClass OriginalSEL:(SEL)originalSEL TonewSEL:(SEL)newSEL;
@end
