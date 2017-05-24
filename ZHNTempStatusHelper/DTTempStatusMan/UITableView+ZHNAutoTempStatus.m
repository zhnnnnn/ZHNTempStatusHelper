//
//  UITableView+ZHNAutoTempStatus.m
//  ZHNtemp
//
//  Created by zhn on 2017/4/10.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "UITableView+ZHNAutoTempStatus.h"
#import "UIViewController+ZHNAutoTempStatus.h"
#import "ZHNMethodSwizzingHelper.h"

@interface UITableView()
@property (nonatomic,strong) UIView *placeHolderView;
@property (nonatomic,assign) BOOL isReloaded;
@end

@implementation UITableView (ZHNAutoTempStatus)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ZHNMethodSwizzingHelper swizzinClass:[self class] OriginalSEL:@selector(reloadData) TonewSEL:@selector(ZHN_reloadData)];
    });
}

- (void)ZHN_reloadData {
    [self ZHN_reloadData];
    [self p_checkEmpty];
}
#pragma mark - pravite Methods
- (void)p_checkEmpty {
    if (!self.isReloaded) {
        self.isReloaded = YES;
        return;
    }
    UIView *tempPlaceholderView = [self.superViewController ZHN_tempStatusPlaceholderView];
    BOOL enableScroll = [self.superViewController ZHN_tempStatusEnableTableViewScroll];
    if (!tempPlaceholderView) {return;}
    // 检查空状态
    BOOL isEmpty = YES;
    id <UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int index = 0; index < sections; index++) {
        NSInteger row = [src tableView:self numberOfRowsInSection:index];
        if (row) {
            isEmpty = NO;
            break;
        }
    }
    // 添加placeHolder
    if (isEmpty) {
        [self.placeHolderView removeFromSuperview];
        self.placeHolderView = nil;
        self.placeHolderView = tempPlaceholderView;
        tempPlaceholderView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.placeHolderView];
        self.scrollEnabled = enableScroll;
    }
    if (!isEmpty) {
        [self.placeHolderView removeFromSuperview];
        self.placeHolderView = nil;
        self.scrollEnabled = YES;
    }
}
#pragma mark - getters getters
- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}
- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIViewController *)superViewController {
    return objc_getAssociatedObject(self, @selector(superViewController));
}

- (void)setSuperViewController:(UIViewController *)superViewController {
    objc_setAssociatedObject(self, @selector(superViewController), superViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isReloaded {
    return [objc_getAssociatedObject(self, @selector(isReloaded)) boolValue];
}

- (void)setIsReloaded:(BOOL)isReloaded {
    objc_setAssociatedObject(self, @selector(isReloaded), @(isReloaded), OBJC_ASSOCIATION_ASSIGN);
}

@end
