//
//  MTTargetMaker.h
//  MTNOP
//
//  Created by renwanqian on 14-4-22.
//  Copyright (c) 2014年 cn.mastercom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTGlobalInfo.h"
@interface MTTargetMaker : NSObject
+ (instancetype)sharedInstance;
- (id)fromClassName:(NSString *)className;
- (id)fromClassName:(NSString *)className libName:(NSString *)libName;
- (id)fromClassName:(NSString *)className libName:(NSString *)libName bundleName:(NSString *)bundleName;
- (id)fromClassName:(NSString *)className libName:(NSString *)libName bundleName:(NSString *)bundleName nibName:(NSString *)nibName;

- (Class)getBranchedClass:(NSString *)className libName:(NSString *)libName;
@end
