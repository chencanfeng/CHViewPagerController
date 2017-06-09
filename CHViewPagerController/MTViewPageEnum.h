//
//  MTViewPageEnum.h
//  UICommon
//
//  Created by jianke on 15/6/1.
//  Copyright (c) 2015年 YN. All rights reserved.
//

#ifndef UICommon_MTViewPageEnum_h
#define UICommon_MTViewPageEnum_h

typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab,
    ViewPagerOptionFixFormerTabsPositions,
    ViewPagerOptionFixLatterTabsPositions
};

/**
 * Main parts of the MTViewPage
 *
 * ViewPagerIndicator: The colored line in the view of the active tab
 * ViewPagerTabsView: The tabs view itself
 * ViewPagerContent: Provided views goes here as content
 */
typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent
};
#endif
