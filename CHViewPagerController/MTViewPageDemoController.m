//
//  MTViewPageDemoController.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MTViewPageDemoController.h"
#import "CHFirstViewController.h"
#import "CHSecondViewController.h"
@interface MTViewPageDemoController ()
@property (nonatomic) NSUInteger numberOfTabs;
@end

@implementation MTViewPageDemoController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nil bundle:nibBundleOrNil];
    return  self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = self;
    self.delegate = self;
    
     //Keeps tab bar below navigation bar on iOS 7.0+
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
         self.edgesForExtendedLayout = UIRectEdgeNone;
     }
    
   
    
    UIBarButtonItem *button;
    button = [[UIBarButtonItem alloc] initWithTitle:@"Tab #2" style:UIBarButtonItemStylePlain target:self action:@selector(selectTabWithNumber2)];
    
    [self setNaviTitle: @"View Pager" leftButtonShow:YES rightButtom:button];
    self.numberOfTabs = 5;
    // [self performSelector:@selector(loadContent) withObject:nil afterDelay:1.0];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//- (void)loadContent {
//    self.numberOfTabs = 5;
//}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(MTViewPagerController *)viewPager {
    return self.numberOfTabs;
}
- (UIView *)viewPager:(MTViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%ld", index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}
-(void)  viewPager:(MTViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    NSLog(@"%s + %ld",__func__,index);
}


- (UIView *)viewPager:(MTViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;
{
    UIView* view=[[UIView alloc] init];
    view.backgroundColor =[UIColor grayColor];
    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.text=[NSString stringWithFormat:@"View #%ld", index];
    [view addSubview:label];
    return view;
    //  return nil;
}

//- (UIViewController *)viewPager:(MTViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
//    
////    MTCommonViewController *cvc =[[MTTargetMaker sharedInstance] fromClassName:@"MTCommonViewController"];
//    
//    //    cvc.navTitle = [NSString stringWithFormat:@"Content View #%i", index];
//    //
//    //    return cvc;
//    
//    if(index == 0) {
//        CHFirstViewController *vc = [[CHFirstViewController alloc] init];
//        vc.view.backgroundColor = [UIColor whiteColor];
//        return vc;
//    }else {
//        CHSecondViewController *vc = [[CHSecondViewController alloc] init];
//        vc.view.backgroundColor = [UIColor orangeColor];
//        return vc;
//    }
//
//    
//}

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

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(MTViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
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
            return self.view.frame.size.width/_numberOfTabs;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 0.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(MTViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
