//
//  MTSegmentedDemoViewController.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MTSegmentedDemoViewController.h"
#import "MT9GridViewDemo.h"
//#import "MTPageViewController.h"
@interface MTSegmentedDemoViewController ()

@end

@implementation MTSegmentedDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        NSArray* items= @[@{@"name":@"九宫格",@"className":@"MT9GridViewDemo",@"params":@{},@"type":@(1)},
                          @{@"name":@"滑动视图",@"className":@"MTViewPageDemo",@"params":@{},@"type":@(1)},
                          @{@"name":@"LTE",@"className":@"MT9GridViewDemo",@"params":@{},@"type":@(1)}
                          ];
        self.segmentedControlItems=items;
        self.position = SegmengedPositionBottom;


    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNaviTitle:@"SegmentVC" leftButtonShow:YES rightButtom:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
