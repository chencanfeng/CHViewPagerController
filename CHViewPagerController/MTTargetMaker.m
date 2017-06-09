//
//  MTTargetMaker.m
//  MTNOP
//
//  Created by renwanqian on 14-4-22.
//  Copyright (c) 2014年 cn.mastercom. All rights reserved.
//

#import "MTTargetMaker.h"


@interface MTTargetMaker(){
    NSMutableDictionary *_bundleDict;
}
@end
@implementation MTTargetMaker


- (id)init {
	self = [super init];
	if (self) {
		_bundleDict = [NSMutableDictionary dictionaryWithCapacity:100];
	}
	return self;
}

+ (instancetype)sharedInstance {
	static MTTargetMaker *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedInstance = [[MTTargetMaker alloc] init];
	});
    
	return sharedInstance;
}

- (Class)getBranchedClass:(NSString *)className libName:(NSString *)libName{
    Class branchedClass = nil;
    //先看组件分支定义是否有相应的分支类
    if (libName) {
        NSString *component = nil;
        NSRange range = [libName rangeOfString:@"_" options:NSBackwardsSearch];
        if (range.length > 0) {
            component = [libName substringFromIndex:range.location + 1];
        } else {
            component = libName;
        }
        
        NSString *branch = (NSString *)[[MTGlobalInfo sharedInstance].appInfoDict valueForKey:[@"Branch_" stringByAppendingString:component]];
        if (branch) {
            branchedClass = NSClassFromString([[className stringByAppendingString:@"_"] stringByAppendingString:branch]);
        }
        
        if (branchedClass) {
            return branchedClass;
        }
    }
    
    // 再看App分支定义是否有相应的分支类
    NSString *branch = (NSString *)[[MTGlobalInfo sharedInstance].appInfoDict valueForKey:@"Branch_App"];
    if (branch) {
        branchedClass = NSClassFromString([[className stringByAppendingString:@"_"] stringByAppendingString:branch]);
    }
    if (branchedClass) {
        return branchedClass;
    }
    
    //原始分支
    branchedClass = NSClassFromString(className);
    if(branchedClass){
        return branchedClass;
    }
    //再看Base分支是否有相应的分支类
    branchedClass = NSClassFromString([[className stringByAppendingString:@"_"] stringByAppendingString:@"Base"]);
    if(branchedClass){
        return branchedClass;
    }
    return nil;
}

- (id)fromClassName:(NSString *)className{
    return [self fromClassName:className libName:nil];
}


- (id)fromClassName:(NSString *)className libName:(NSString *)libName{
    if ([className hasPrefix:@"call "]) {//调用第三方的程序
        //TODO：
        return nil;
    }
    Class class = [self getBranchedClass:className libName:libName];
    id target = [class alloc];

    if ([target isKindOfClass:[UIView class]]) {
        return [target init];
    } else if ([target isKindOfClass:[UINavigationController class]]) {
        //自定义UINavigationController重写initWithRootViewController方法
        return [target initWithRootViewController:nil];
    } else if ([target isKindOfClass:[UIViewController class]]){
        return [self initViewController:target bundleName:[libName stringByAppendingString:@"Bundle"] nibName:className];
    } else {
        return [target init];
    }
}

- (id)fromClassName:(NSString *)className libName:(NSString *)libName bundleName:(NSString *)bundleName{
    return [self fromClassName:className libName:libName bundleName:bundleName nibName:className];
}

- (id)fromClassName:(NSString *)className libName:(NSString *)libName bundleName:(NSString *)bundleName nibName:(NSString *)nibName{
    id vc = [[self getBranchedClass:className libName:libName] alloc];
    return [self initViewController:vc bundleName:bundleName nibName:nibName];
}

- (id)initViewController:(id)vc bundleName:(NSString *)bundleName nibName:(NSString *)nibName{
    NSBundle *bundle = nil;
    if (bundleName) {
        bundle = (NSBundle *)[_bundleDict valueForKey:bundleName];
        if (bundle == nil) {
            NSURL *url = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
            if (url) {
                bundle = [NSBundle bundleWithURL:url];
            }
            
            if (bundle) {
                [_bundleDict setObject:bundle forKey:bundleName];
            }
        }
    }else{
        bundle = [NSBundle mainBundle];
    }
    
    BOOL exist = [bundle pathForResource:nibName ofType:@"nib"] != nil;
    if (exist) {
        return [vc initWithNibName:nibName bundle:bundle];
    }else{
        return [vc init];
    }
}
@end
