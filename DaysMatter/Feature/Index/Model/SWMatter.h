//
//  SWMatter.h
//  DaysMatter
//
//  Created by 宋国华 on 2018/10/12.
//  Copyright © 2018年 songguohua. All rights reserved.
//

#import <Realm/Realm.h>

@interface SWMatter : RLMObject

@property (readonly) NSInteger apart;
@property NSDate *date;
@property NSString *title;
@property NSString *category;
@property NSString *categoryImageName;

@end

