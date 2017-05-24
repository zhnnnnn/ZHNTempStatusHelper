//
//  UICollectionView+ZHNAutoTempStatus.m
//  ZHNTempStatusHelper
//
//  Created by zhn on 2017/4/18.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "UICollectionView+ZHNAutoTempStatus.h"
#import "UITableView+ZHNAutoTempStatus.h"
#import "UIViewController+ZHNAutoTempStatus.h"
#import "ZHNMethodSwizzingHelper.h"

@interface UICollectionView()
@property (nonatomic,strong) UIView *placeHolderView;
@property (nonatomic,assign) BOOL isReloaded;
@end

@implementation UICollectionView (ZHNAutoTempStatus)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ZHNMethodSwizzingHelper swizzinClass:[self class] OriginalSEL:@selector(reloadData) TonewSEL:@selector(ZHN_reloadData)];
    });
}

- (void)zhn_reloadData {
    [self zhn_reloadData];
    [self p_checkEmpty];
}

#pragma mark - pravite Methods
- (void)p_checkEmpty {
    if (!self.isReloaded) {
        self.isReloaded = YES;
        return;
    }
    UIView *tempPlaceholderView = [self.supViewController ZHN_tempStatusPlaceholderView];
    BOOL enableScroll = [self.supViewController ZHN_tempStatusEnableTableViewScroll];
    if (!tempPlaceholderView) {return;}
    // 检查空状态
    BOOL isEmpty = YES;
    id <UICollectionViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [src numberOfSectionsInCollectionView:self];
    }
    for (int index = 0; index < sections; index++) {
        NSInteger row = [src collectionView:self numberOfItemsInSection:index];
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

#pragma mark - setters getters
- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)supViewController {
    return objc_getAssociatedObject(self, @selector(supViewController));
}

- (void)setSupViewController:(UIViewController *)supViewController {
    objc_setAssociatedObject(self, @selector(supViewController), supViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isReloaded {
    return [objc_getAssociatedObject(self, @selector(isReloaded)) boolValue];
}

- (void)setIsReloaded:(BOOL)isReloaded {
    objc_setAssociatedObject(self, @selector(isReloaded), @(isReloaded), OBJC_ASSOCIATION_ASSIGN);
}
@end
