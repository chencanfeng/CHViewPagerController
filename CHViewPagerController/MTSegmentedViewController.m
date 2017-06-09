//
//  MTSegmentedViewController.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MTSegmentedViewController.h"

#import "CHUtils.h"
#import "MTTargetMaker.h"

@implementation SegmentedItemInfo

@end

@interface MTSegmentedViewController ()

@end

@implementation MTSegmentedViewController {
    NSMutableArray *segmenteds;
    BOOL firstViewSelected;
}
/**
 *    eg: items=
 *@[@{@"name":@"GSM",@"className":@"",@"params":@{},@"type":@(1)},
 *       @{@"name":@"TD",@"className":@"",@"params":@{},@"type":@(1)},
 *       @{@"name":@"LTE",@"className":@"",@"params":@{},@"type":@(1)}
 *        ];
 *      type=1 代表文字 type=2代表 图片
 **/
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nibBundleOrNil];
    if (self) {
        firstViewSelected = false;
        segmenteds = [[NSMutableArray alloc] init];
        self.position = SegmengedPositionBottom;
        _fixedView = [[UIView alloc] init];
        _fixedView.backgroundColor = [UIColor clearColor];
        _segmentedBackgroudView = [[UIView alloc] init];
        _fixedViewHeight = 0;
    }
    return self;
}

- (id)initSegmentedItems:(NSArray *)items
            withPosition:(SegmengedPosition)position {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        segmenteds = [[NSMutableArray alloc] init];
        _segmentedControlItems = items;
        self.position = position;
        firstViewSelected = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!firstViewSelected) {
        [self showFirstView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSegmenteds];
    if (_segmentedControl && [segmenteds count] > 1) {
        // segmentedControl 的背景
        [self.view addSubview:_segmentedBackgroudView];
        _segmentedBackgroudView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_segmentedBackgroudView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_segmentedBackgroudView)]];

        // segmentedControl 的背景中添加 segmentedControl
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        [_segmentedBackgroudView addSubview:_segmentedControl];
        CGFloat width = [self sizeSegmentedControlFits];
        [_segmentedBackgroudView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[_segmentedControl(%f)]", width] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_segmentedControl)]];
        [_segmentedBackgroudView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_segmentedControl(29)]-6-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_segmentedControl)]];
        [_segmentedBackgroudView addConstraint:[NSLayoutConstraint constraintWithItem:_segmentedControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_segmentedBackgroudView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        
        _fixedView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_fixedView];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_fixedView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fixedView)]];
        
        NSString *format_segback, *format_fix;
        if (self.position == SegmengedPositionTop) {
            format_segback = @"V:|-0-[_segmentedBackgroudView(40)]";
            format_fix = [NSString stringWithFormat:@"V:[_fixedView(%d)]-0-|", _fixedViewHeight];
        } else {
            format_segback = @"V:[_segmentedBackgroudView(40)]-0-|";
            format_fix = [NSString stringWithFormat:@"V:|-0-[_fixedView(%d)]", _fixedViewHeight];
        }
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format_segback options:0 metrics:nil views:NSDictionaryOfVariableBindings(_segmentedBackgroudView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format_fix options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fixedView)]];
    }
}

/**
 *  获取 segmentedControl 的最佳宽度
 */
- (CGFloat)sizeSegmentedControlFits {
    CGFloat totalWidth = 0.0;
    NSUInteger num = _segmentedControl.numberOfSegments;
    for (int i = 0; i < num; i++) {
        NSString *title = [_segmentedControl titleForSegmentAtIndex:i];
        CGFloat width =
        [title sizeWithAttributeFont:[UIFont systemFontOfSize:12.0]].width + 30;
        totalWidth += width;
        [_segmentedControl setWidth:width forSegmentAtIndex:i];
    }
    return totalWidth;
}

- (id)addSegmentedItem:(NSString *)name
             imageName:(NSString *)imageName
     selectedImageName:(NSString *)selectedImageName
             className:(NSString *)className
                params:(NSDictionary *)params {
    return nil;
}

/**
 *  根据传入的 segmented 信息初始化界面信息
 */
- (void)makeSegmenteds {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    // 获取 中间显示 view 的数组信息
    for (NSDictionary *dic in _segmentedControlItems) {
        // type : 在 segmented 中显示的是 图片 / 文字 的类型（SegmengedType）
        // name : 在segmented 中显示的文字信息 / 图片信息的图片名称
        // param : segmented 对应的控制器的显示参数
        // className : segmented 对应的控制器的类名
        NSString *name = [dic valueForKey:@"name"];
        if ([[dic valueForKey:@"type"] integerValue] == SegmengedTypeText) {
            [arr addObject:name];
        } else {
            UIImage *img = [UIImage imageNamed:name];
            [arr addObject:img];
        }
        NSDictionary *param = [dic valueForKey:@"param"];
        NSString *className = [dic valueForKey:@"className"];
        
        SegmentedItemInfo *item = [[SegmentedItemInfo alloc] init];
        item.className = className;
        item.name = name;
        item.param = param;
        item.contentView = [self creatContentView:className params:param];
        [segmenteds addObject:item];
    }
    
    // 初始化 segmentedControl
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:arr];
    [_segmentedControl addTarget:self
                          action:@selector(segmentedValueChangedAction:)
                forControlEvents:UIControlEventValueChanged];
}

- (void)showFirstView {
    if ([segmenteds count] == 0) return;
    
    firstViewSelected = YES;
    if (_segmentedControl.numberOfSegments > 1) {
        _segmentedControl.selectedSegmentIndex = 0;
    }
    SegmentedItemInfo *item = [segmenteds objectAtIndex:0];
    
    UIView *view = item.contentView;
    view.hidden = NO;
    self.currentView = view;
    [view layoutIfNeeded];
}

- (void)onSegmentChange:(NSInteger)index view:(UIView *)view {
}

/**
 *  segmentedControl 选择的值变化的处理事件
 */
- (void)segmentedValueChangedAction:(UISegmentedControl *)segmentedControl {
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    for (int i = 0; i < segmentedControl.numberOfSegments; i++) {
        if (i == index) {
            continue;
        }
        SegmentedItemInfo *item = [segmenteds objectAtIndex:i];
        UIView *view = item.contentView;
        view.hidden = YES;
    }
    
    [self selectSegmentedView:index];
}

/**
 *  创建中间显示的 view
 *
 *  @param className viewController 的类名
 *  @param params    参数
 *
 *  @return viewController 的 view
 */
- (id)creatContentView:(NSString *)className params:(NSDictionary *)params {
    Class class = NSClassFromString(className);
    if ([class isSubclassOfClass:UIViewController.class]) {
        UIViewController *view =
        [[MTTargetMaker sharedInstance] fromClassName:className];
        if (params) {
            @try {
                [view setValuesForKeysWithDictionary:params];
            } @catch (NSException *ex) {
            }
        }
        @try {
            [view setValue:self forKey:@"parentVC"];
        } @catch (NSException *ex) {
        }
        return view;
    } else if ([class isSubclassOfClass:UIView.class]) {
        UIView *view = [[MTTargetMaker sharedInstance] fromClassName:className];
        if (view) {
            if (params) {
                @try {
                    [view setValuesForKeysWithDictionary:params];
                } @catch (NSException *ex) {
                }
            }
            @try {
                [view setValue:self forKey:@"parentVC"];
            } @catch (NSException *exception) {
            }
            view.translatesAutoresizingMaskIntoConstraints = NO;
            // 添加 segmented 对应的 view
            [self.view addSubview:view];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];

            NSString *format =
            (self.position == SegmengedPositionTop) ? [NSString stringWithFormat:@"V:|-24-[view]-%d-|", _fixedViewHeight]
            : [NSString stringWithFormat:@"V:|-%d-[view]-40-|", _fixedViewHeight];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
            
            view.hidden = YES;
        }
        return view;
    }
    return nil;
}
- (id)getSegmentedView:(NSInteger)index {
    if (index < 0 || index >= [segmenteds count]) {
        return nil;
    }
    SegmentedItemInfo *info = [segmenteds objectAtIndex:index];
    return info.contentView;
}

/**
 *  根据选中的 segmented 的 index 处理当前显示的 view
 */
- (void)selectSegmentedView:(NSInteger)index {
    if (index < 0 || index >= [segmenteds count]) {
        return;
    }
    SegmentedItemInfo *item = [segmenteds objectAtIndex:index];
    UIView *view = item.contentView;
    if (view) {
        view.hidden = NO;
        self.currentView = view;
        [view layoutSubviews];
    }
    [self onSegmentChange:index view:view];
}

@end
