//
//  UIViewController+ZHNAutoTempStatus.h
//  ZHNtemp
//
//  Created by zhn on 2017/4/10.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZHNAutoTempStatus)
- (UIView *)ZHN_tempStatusPlaceholderView;
- (BOOL)ZHN_tempStatusEnableTableViewScrollView;
@end
