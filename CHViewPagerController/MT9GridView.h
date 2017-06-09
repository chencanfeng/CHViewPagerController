//
//  MT9GridView.h
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseViewController.h"
#import "GridItem.h"

@interface GridItemButton : UIButton

@property(nonatomic, strong) NSString *uuid;

- (id)initFrameWithGridItem:(CGRect)frame withGridItem:(GridItem *)gridItem;

- (void)setBadgeNumber:(NSString *)badgeNumber;

@property(nonatomic, strong) UIButton *deleteBtn;

@property(nonatomic) GridItem *gridItem;

@end

@protocol MT9GridViewDelegate <NSObject>

- (void)didSelectedGridItem:(GridItem *)gridItem;

@optional
- (BOOL)editingEnableForItemAtIndex:(NSInteger)index;
- (void)deleteItemAtIndex:(NSInteger)index;

@end

@interface MT9GridView : UIScrollView <UIScrollViewDelegate> {
  BOOL haveLoaded;
}

@property(nonatomic) NSString *pageIndicatorTintColor;
@property(nonatomic) NSString *currentPageIndicatorTintColor;
@property(nonatomic, strong) MTBaseViewController *parentVC;
/**
 每个模块的信息数组
 gridItemsArr 中为 dictionary 的数组
 dictionary 中字段意思
 1.classname : 跳转控制器的名称
 2.lableName : 标题
 3.iconName  : 图标名称
 4.param     : 跳转控制器的参数信息
 */
@property(nonatomic) NSArray *gridItemsArr;
@property(nonatomic) NSString *labelColor;
@property(nonatomic, assign) id<MT9GridViewDelegate> gridViewDelegate;
@property(nonatomic, assign) BOOL editing;
- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items;

- (void)updateIconBadgeNumbers:(NSArray *)badgeNumbers;

- (void)updateIconBadgeNumberWithKey:(NSInteger)badgeNumber
                             withKey:(NSString *)key;

@end
