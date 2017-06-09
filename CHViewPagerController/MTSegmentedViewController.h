//
//  MTSegmentedViewController.h
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "MTBaseViewController.h"

@interface SegmentedItemInfo : NSObject
@property (nonatomic, strong)  NSString *name;
@property (nonatomic, strong)  UIImageView *imgView;
@property (nonatomic, strong)  NSString *className;
@property (nonatomic, strong)  NSDictionary *param;
@property (nonatomic, strong)  id contentView;

@end

/**
 Segmenged 的在视图当中的位置
 */
typedef enum : NSUInteger {
    SegmengedPositionTop, // 在顶部
    SegmengedPositionBottom, // 在底部
    
} SegmengedPosition ;

typedef enum : NSUInteger {
    SegmengedTypeText=1,
    SegmengedTypeImage=2,
    
} SegmengedType ;

@interface MTSegmentedViewController : MTBaseViewController

@property (nonatomic) UISegmentedControl* segmentedControl;
/** segment 的位置 */
@property (nonatomic) SegmengedPosition position;
@property (nonatomic) id currentView;

@property (nonatomic,strong) UIView *segmentedBackgroudView;
@property (nonatomic,strong) UIView *fixedView;
@property (nonatomic,assign) int fixedViewHeight;

/** 模块列表参数信息 */
@property (nonatomic,strong) NSArray *segmentedControlItems;

-(id) initSegmentedItems:(NSArray*) items withPosition:(SegmengedPosition) position;
-(id)addSegmentedItem:(NSString*)name imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName className:(NSString*)className params:(NSDictionary*)params;
-(id)getSegmentedView:(NSInteger)index;
-(void)selectSegmentedView:(NSInteger)index;

@end
