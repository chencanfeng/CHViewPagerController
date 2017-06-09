//
//  MT9GridViewDemo.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MT9GridViewDemo.h"

#import "MTTargetMaker.h"

@implementation MT9GridViewDemo



-(id) initWithFrame:(CGRect)frame
{
    
    self= [super  initWithFrame:frame];
    if (self) {
        NSArray* items =@[
                       @{@"className":@"MTViewPageDemoController",@"labelName":@"滑动控制器1",@"iconName":@"app_icon.png",@"param":@{@"viewPagerOptionTabLocation":@(0)}},
                       @{@"className":@"MTViewPageDemoController",@"labelName":@"滑动控制器2",@"iconName":@"app_icon.png",@"param":@{@"viewPagerOptionTabLocation":@(1)}},
                       @{@"className":@"BaseDataQueryViewController",@"labelName":@"基础数据",@"iconName":@"app_icon.png"},
                       @{@"className":@"NeighbourMessage2GViewController",@"labelName":@"邻区关系",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"性能问题点",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"参数查询",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区15分钟",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区匹配",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"工单升级",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"直放站查询",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"规划大站",@"iconName":@"wired.png"},
                       @{@"className":@"BMapViewController",@"labelName":@"电子地图",@"iconName":@"app_clbg_t"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区性能",@"iconName":@"globe.png"},
                       @{@"className":@"TestViewController",@"labelName":@"主设备工单",@"iconName":@"lock.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"参数查询",@"iconName":@"webcam.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区15分钟",@"iconName":@"promotion.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区匹配",@"iconName":@"1-首页_20.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"工单升级",@"iconName":@"sh.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"直放站查询",@"iconName":@"zoom_in.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"规划大站",@"iconName":@"wired.png"},
                       @{@"className":@"BMapViewController",@"labelName":@"电子地图",@"iconName":@"app_clbg_t"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区性能",@"iconName":@"globe.png"},
                       @{@"className":@"TestViewController",@"labelName":@"主设备工单",@"iconName":@"app_icon.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"参数查询",@"iconName":@"webcam.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区15分钟",@"iconName":@"promotion.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区匹配",@"iconName":@"1-首页_20.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"工单升级",@"iconName":@"sh.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"直放站查询",@"iconName":@"zoom_in.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"规划大站",@"iconName":@"wired.png"},
                       @{@"className":@"BMapViewController",@"labelName":@"电子地图",@"iconName":@"app_clbg_t"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区性能",@"iconName":@"globe.png"},
                       @{@"className":@"TestViewController",@"labelName":@"主设备工单",@"iconName":@"lock.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"参数查询",@"iconName":@"webcam.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区15分钟",@"iconName":@"promotion.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区匹配",@"iconName":@"1-首页_20.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"工单升级",@"iconName":@"sh.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"直放站查询",@"iconName":@"zoom_in.png"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"规划大站",@"iconName":@"app_icon.png"},
                       @{@"className":@"BMapViewController",@"labelName":@"电子地图",@"iconName":@"app_clbg_t"},
                       @{@"className":@"MTNetOptWirelessMainViewController",@"labelName":@"小区性能",@"iconName":@"app_icon.png"},
                       @{@"className":@"TestViewController",@"labelName":@"主设备工单",@"iconName":@"lock.png"},
                       @{@"className":@"DataUpdate",@"labelName":@"数据更新",@"iconName":@"refresh.png"}
                       ];
        self.gridItemsArr = items;
        self.labelColor=@"0x000000";
        self.gridViewDelegate=self;
        self.pageIndicatorTintColor=@"0xd7d70d7";
        self.currentPageIndicatorTintColor=@"0xff0000";
    }
    
    return self;
    
}
-(void) didSelectedGridItem:(GridItem *)gridItem
{
    NSLog(@"%@",gridItem.className);
    
    id target = [[MTTargetMaker sharedInstance] fromClassName:gridItem.className];
    if(target == nil){
        return;
    }
    if([target isKindOfClass:MTBaseViewController.class]){
        MTBaseViewController *vc = (MTBaseViewController*)target;
        @try {
            [vc setValuesForKeysWithDictionary:gridItem.param];
        }
        @catch (NSException *exception) {
            
        }
        [self.parentVC pushViewController:vc navigationBarHidden:NO];
    
    }else if([target isKindOfClass:UIViewController.class]){
        UIViewController *vc = (UIViewController*)target;
        @try {
             [vc setValuesForKeysWithDictionary:gridItem.param];
        }
        @catch (NSException *exception) {
            
        }
       
        //[vc setValue:param forKey:@"paramString"];
        [self.parentVC pushViewController:vc navigationBarHidden:NO];
        
    }
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
