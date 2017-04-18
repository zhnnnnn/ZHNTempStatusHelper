//
//  UITableView+ZHNAutoTempStatus.h
//  ZHNtemp
//
//  Created by zhn on 2017/4/10.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

void zhn_tempStatus_swizzingMethod(Class class,SEL orig,SEL new){
    Method origMethod = class_getInstanceMethod(class, orig);
    Method newMethod = class_getInstanceMethod(class, new);
    if (class_addMethod(class, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@interface UITableView (ZHNAutoTempStatus)
@property (nonatomic,weak) UIViewController *superViewController;
@end
