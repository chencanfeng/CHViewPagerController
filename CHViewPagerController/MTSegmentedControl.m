//
//  MTSegmentedControl.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//


#import "MTSegmentedControl.h"
#import "CHUtils.h"
#import "MTGlobalInfo.h"




@implementation MTSegmentedControl

- (void)awakeFromNib {
	[super awakeFromNib];
    
	[self setupAppearance];
}

- (id)initWithItems:(NSArray *)items {
	self = [super initWithItems:items];
	if (self) {
		[self setupAppearance];
	}
    
	return self;
}

- (void)setupAppearance {
	self.segmentedControlStyle = UISegmentedControlStyleBar;
    
	[self setBackgroundImage:[UIImage imageNamed:@"tab_selsected" bundle:[MTGlobalInfo sharedInstance].commBundle] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
	[self setBackgroundImage:[UIImage imageNamed:@"tab_unselected" bundle:[MTGlobalInfo sharedInstance].commBundle] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
	[self setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[self setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[self setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
	[self setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:13.0] } forState:UIControlStateNormal];
	[self setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:13.0] } forState:UIControlStateSelected];
}

@end
