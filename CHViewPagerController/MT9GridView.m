//
//  MT9GridView.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MT9GridView.h"
#import "CHUtils.h"
//#import "AsyncImageLoader.h"

#define COLUMN 4
#define MAX_PAGE 9
#define GRIDSIZE 40
//#define GAP 10
#define EVERYGRIDSIZE 90
#define WHILTCOLOR @"0xffffff"



@implementation GridItemButton {
    UIView *viewBdage;
    UILabel *labTotal;
    UILabel *titleLabel;
}
- (id)initFrameWithGridItem:(CGRect)frame withGridItem:(GridItem *)gridItem {
    self = [super initWithFrame:frame];
    if (self) {
        self.gridItem = gridItem;
    
        viewBdage = [[UIView alloc] init];
        [self addSubview:viewBdage];
        NSString *iconName = gridItem.iconName;
        UIImage *image;
        if (iconName == nil || [iconName length] == 0) {
            image = nil;
        } else if ([iconName hasPrefix:@"/"]) {
            image = [UIImage imageWithContentsOfFile:iconName];
        } else {
            image = [UIImage imageNamed:iconName];
        }
//        if (!image) {
//            image = [[AsyncImageLoader sharedInstance] obtainImage:iconName
//                                                             imgId:0
//                                                         backBlock:nil];
//        }
        if (gridItem.badgeNumber != nil && gridItem.badgeNumber.length > 0) {
            NSInteger totalUnRead = [gridItem.badgeNumber integerValue];
            NSString *totalStr = totalUnRead > 99
            ? @"N"
            : [NSString stringWithFormat:@"%ld", totalUnRead];
            CGSize size = [totalStr sizeWithFont:[UIFont systemFontOfSize:10]];
            CGFloat width = size.width;
            if (width < 30) {
                width = 30;
            }
            
            viewBdage.frame = CGRectMake(self.frame.size.width - 8, -4, 16, 16);
            viewBdage.backgroundColor = [UIColor redColor];
            viewBdage.layer.cornerRadius = 8;
            labTotal = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
            labTotal.text = totalStr;
            labTotal.font = [UIFont systemFontOfSize:8];
            labTotal.textColor = [UIColor whiteColor];
            labTotal.textAlignment = NSTextAlignmentCenter;
            [viewBdage addSubview:labTotal];
            viewBdage.hidden = totalUnRead == 0;
        }
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(-12, -12, 24, 24)];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"]
                              forState:(UIControlStateNormal)];
        _deleteBtn.hidden = YES;
        _deleteBtn.enabled = NO;
        [self addSubview:_deleteBtn];
        
        titleLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(-10, frame.size.height,
                                                  frame.size.width + 20, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = gridItem.labelName;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeNumber:(NSString *)badgeNumber {
    NSInteger totalUnRead = [badgeNumber integerValue];
    NSString *totalStr =
    totalUnRead > 99 ? @"N" : [NSString stringWithFormat:@"%ld", (long)totalUnRead];
    labTotal.text = totalStr;
    viewBdage.hidden = totalUnRead == 0;
}

@end

@implementation MT9GridView {
    UIPageControl *pageControl;
    
    NSInteger gap;
    NSMutableDictionary *_pagebuttonsDic;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        gap = 10;
        haveLoaded = NO;
        self.labelColor = WHILTCOLOR; //[UIColor whiteColor];
        self.delegate = self;
        _pagebuttonsDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items {
    self = [self initWithFrame:frame];
    if (self) {
        _gridItemsArr = items;
        haveLoaded = NO;
        self.labelColor = WHILTCOLOR;
        self.delegate = self;
    }
    
    return self;
}

- (void)updateIconBadgeNumbers:(NSArray *)badgeNumbers {
    // [_pagesArr addObject:button];
    for (NSDictionary *item in badgeNumbers) {
        NSString *key;
        if ([item.allKeys containsObject:@"uuid"]) {
            
            key = [item objectForKey:@"uuid"];
        }
        
        if ([item.allKeys containsObject:@"badgeNumber"]) {
            if (key.length < 1) {
                key = [item objectForKey:@"labelName"];
            }
            NSString *badgeNumber = [item objectForKey:@"badgeNumber"];
            GridItemButton *button =
            (GridItemButton *)[_pagebuttonsDic valueForKey:key];
            [button setBadgeNumber:badgeNumber];
        }
    }
}

- (void)updateIconBadgeNumberWithKey:(NSInteger)badgeNumber
                             withKey:(NSString *)key {
    GridItemButton *button = (GridItemButton *)[_pagebuttonsDic valueForKey:key];
    [button setBadgeNumber:[NSString stringWithFormat:@"%ld", (long)badgeNumber]];
}

- (void)layoutSubviews {
    if (!haveLoaded) {
        int width = self.frame.size.width;
        int height = self.frame.size.height - 56;
        if (height < 1 || width < 1) {
            return;
        }
        //
        CGFloat avgGap = (width - 64 * COLUMN) / (COLUMN + 1);
        if (avgGap > gap) {
            gap = avgGap;
        }
        // 每一页的个数
        //int countPerPage = height / EVERYGRIDSIZE * COLUMN;
        int countPerPage = height / (EVERYGRIDSIZE + 8) * COLUMN;

        NSInteger totalCount = [_gridItemsArr count];
        int pageCount = ceil(totalCount * 1.0 / countPerPage);
        
        pageControl = [[UIPageControl alloc]
                       initWithFrame:CGRectMake((width - pageCount * 20) / 2, height + 26,
                                                pageCount * 20, 22)];
        pageControl.currentPage = 0;
        if (self.pageIndicatorTintColor) {
            pageControl.pageIndicatorTintColor =
            [UIColor colorWithHexString:self.pageIndicatorTintColor];
        }
        if (self.currentPageIndicatorTintColor) {
            pageControl.currentPageIndicatorTintColor =
            [UIColor colorWithHexString:self.currentPageIndicatorTintColor];
        }
        pageControl.numberOfPages = pageCount;
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        pageControl.hidden = pageCount < 2;
        if (pageCount > MAX_PAGE) {
            @throw [NSException exceptionWithName:@"ERROR"
                                           reason:@"[ERROR] >>> items太大 :("
                                         userInfo:nil];
        }
        
        self.contentSize = CGSizeMake(width * pageCount, height);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        for (int currentPage = 0; currentPage < pageCount; currentPage++) {
            UIView *pageView = [[UIView alloc]
                                initWithFrame:CGRectMake(currentPage * width, 0, width, height)];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            if (currentPage < pageCount - 1) {
                for (int i = 0; i < countPerPage; i++) {
                    int index = currentPage * countPerPage + i;
                    
                    [tempArray addObject:[_gridItemsArr objectAtIndex:index]];
                }
            } else {
                int startIndex = currentPage * countPerPage;
                for (int i = startIndex; i < totalCount; i++) {
                    [tempArray addObject:[_gridItemsArr objectAtIndex:i]];
                }
            }
            
            NSInteger count = [tempArray count];
            NSInteger row = count / COLUMN + 1;
            if (count > 0) {
                for (int i = 0; i < row; i++) {
                    int column = 0;
                    if (i < row - 1) {
                        column = COLUMN;
                    } else {
                        column = count % COLUMN;
                    }
                    
                    for (int j = 0; j < column; j++) {
                        NSDictionary *item = [tempArray objectAtIndex:i * COLUMN + j];
                        
                        NSString *name = [item objectForKey:@"labelName"];
                        NSString *image = [item objectForKey:@"iconName"];
                        NSString *className = [item objectForKey:@"className"];
                        
                        NSDictionary *param = [item objectForKey:@"param"];
                        GridItem *gridItem = [[GridItem alloc] init];
                        gridItem.labelName = name;
                        gridItem.iconName = image;
                        gridItem.className = className;
                        gridItem.param = param;
                        gridItem.index = i * COLUMN + j;
                        if ([item.allKeys containsObject:@"badgeNumber"]) {
                            gridItem.badgeNumber = [item objectForKey:@"badgeNumber"];
                        }
                        
                        CGRect rect = CGRectMake(gap + j * (64 + gap),
                                                 gap + (i * (EVERYGRIDSIZE + 8)), 64, 64);
                        GridItemButton *button =
                        [[GridItemButton alloc] initFrameWithGridItem:rect
                                                         withGridItem:gridItem];
                        NSLog(@"GridItemButton%@", NSStringFromCGRect(button.frame));
                        if ([item.allKeys containsObject:@"uuid"]) {
                            NSString *uuid = [item objectForKey:@"uuid"];
                            button.uuid = uuid;
                        } else {
                            button.uuid = name;
                        }
                        [button addTarget:self
                                   action:@selector(itemClickAction:)
                         forControlEvents:UIControlEventTouchUpInside];
                        
                        button.tag = i * COLUMN + j;
                        [pageView addSubview:button];
                        [_pagebuttonsDic setObject:button forKey:button.uuid];
                    }
                }
            }
            haveLoaded = YES;
            
            [self addSubview:pageView];
        }
    }
    [super layoutSubviews];
}

- (void)itemClickAction:(id)sender {
    GridItemButton *button = (GridItemButton *)sender;
    if (self.gridViewDelegate &&
        [self.gridViewDelegate
         respondsToSelector:@selector(didSelectedGridItem:)]) {
            [self.gridViewDelegate didSelectedGridItem:button.gridItem];
        }
}

- (void)longPressItem:(id)sender {
}

- (void)deleteItem:(id)sender {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger pageIndex = lround(fractionalPage);
    
    if (previousPage != pageIndex) {
        previousPage = pageIndex;
        pageControl.currentPage = pageIndex;
    }
    
    [self reSetPageControlPosition:fractionalPage];
}

- (void)reSetPageControlPosition:(CGFloat)pageIndex {
    NSInteger pageCount = pageControl.numberOfPages;
    CGFloat x = self.frame.size.width * pageIndex +
    (self.frame.size.width - pageCount * 20) / 2;
    pageControl.frame =
    CGRectMake(x, self.frame.size.height - 30, pageCount * 20, 22);
    NSLog(@"%@", NSStringFromCGRect(pageControl.frame));
}

@end
