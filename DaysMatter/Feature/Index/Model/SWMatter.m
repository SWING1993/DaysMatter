//
//  SWMatter.m
//  DaysMatter
//
//  Created by 宋国华 on 2018/10/12.
//  Copyright © 2018年 songguohua. All rights reserved.
//

#import "SWMatter.h"

@implementation SWMatter

- (NSInteger)apart {
    return [NSDate getDaysFrom:[NSDate date] To:self.date];
}

@end
