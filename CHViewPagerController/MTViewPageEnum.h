//
//  MTViewPageEnum.h
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#ifndef UICommon_MTViewPageEnum_h
#define UICommon_MTViewPageEnum_h

/**
 * Every option has a default value.
 *
 * ViewPagerOptionTabHeight: Tab bar's height, defaults to 44.0
 * ViewPagerOptionTabOffset: Tab bar's offset from left, defaults to 56.0
 * ViewPagerOptionTabWidth: Any tab item's width, defaults to 128.0
 * ViewPagerOptionTabLocation: 1.0: Top, 0.0: Bottom, Defaults to Top
 * ViewPagerOptionStartFromSecondTab: 1.0: YES, 0.0: NO, defines if view should appear with the 1st or 2nd tab. Defaults to NO
 * ViewPagerOptionCenterCurrentTab: 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth. Defaults to NO
 * ViewPagerOptionFixFormerTabsPositions: 1.0: YES, 0.0: NO, defines if the active tab should be placed margined by the offset amount to the left. Effects only the former tabs. If set 1.0 (YES), first tab will be placed at the same position with the second one, leaving space before itself. Defaults to NO
 * ViewPagerOptionFixLatterTabsPositions: 1.0: YES, 0.0: NO, like ViewPagerOptionFixFormerTabsPositions, but effects the latter tabs, making them leave space after themselves. Defaults to NO
 */

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
