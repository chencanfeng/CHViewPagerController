//
//  GridItem.h
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridItem : NSObject<NSCoding>
@property (nonatomic,strong) NSString* uuid;
@property (nonatomic,copy) NSString* className;
@property (nonatomic,copy) NSString* labelName;
@property (nonatomic,copy) NSString* iconName;
@property (nonatomic,copy) NSString* badgeName;
@property (nonatomic,copy) NSString* badgeNumber;
@property (nonatomic,assign) BOOL haveSelected;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic) NSDictionary* param;
- (void) encodeWithCoder:(NSCoder *)aCoder;
- (id) initWithCoder:(NSCoder *)aDecoder;
@end
