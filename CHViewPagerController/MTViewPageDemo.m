//
//  MTViewPageDemo.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MTViewPageDemo.h"

@interface MTViewPageDemo()
    @property (nonatomic) NSUInteger numberOfTabs;

@end

@implementation MTViewPageDemo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.numberOfTabs = 5;
    }
    return self;

    // [self performSelector:@selector(loadContent) withObject:nil afterDelay:1.0];
    
}


#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Helpers
- (void)selectTabWithNumber2 {
    [self selectTabAtIndex:1];
}
- (void)loadContent {
    self.numberOfTabs = 5;
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(MTViewPage *)viewPager {
    return self.numberOfTabs;
}
- (UIView *)viewPager:(MTViewPage *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%ld", index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}
-(void)  viewPager:(MTViewPage *)viewPager didChangeTabToIndex:(NSUInteger)index{
    
}


- (UIView *)viewPager:(MTViewPage *)viewPager contentViewForTabAtIndex:(NSUInteger)index;
{
    UIView* view=[[UIView alloc] init];
    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.text=[NSString stringWithFormat:@"View #%ld", index];
    [view addSubview:label];
    return view;
    //  return nil;
}

//- (UIViewController *)viewPager:(MTViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
//
//    MTCommonViewController *cvc =[[MTTargetMaker sharedInstance] fromClassName:@"MTCommonViewController"];
//
//
//    cvc.navTitle = [NSString stringWithFormat:@"Content View #%i", index];
//
//    return cvc;
//}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(MTViewPage *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0 ;
        case ViewPagerOptionTabHeight:
            return 30.0;
        case ViewPagerOptionTabOffset:
            return 0.0;
        case ViewPagerOptionTabWidth:
            return self.frame.size.width/_numberOfTabs;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 0.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(MTViewPage *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

@end
