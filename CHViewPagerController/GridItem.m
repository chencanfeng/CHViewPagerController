//
//  GridItem.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "GridItem.h"

@implementation GridItem

- (void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:_className forKey:@"className"];
    [aCoder encodeObject:_labelName forKey:@"labelName"];
    [aCoder encodeObject:_iconName forKey:@"iconName"];
    [aCoder encodeObject:_badgeName forKey:@"badgeName"];
    [aCoder encodeObject:_badgeNumber forKey:@"badgeNumber"];
    [aCoder encodeObject:_param forKey:@"param"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self.className = [aDecoder decodeObjectForKey:@"className"];
    self.labelName = [aDecoder decodeObjectForKey:@"labelName"];
    self.iconName = [aDecoder decodeObjectForKey:@"iconName"];
    self.badgeName = [aDecoder decodeObjectForKey:@"badgeName"];
    self.badgeNumber = [aDecoder decodeObjectForKey:@"badgeNumber"];
    self.param = [aDecoder decodeObjectForKey:@"param"];
    return self;
}
@end
