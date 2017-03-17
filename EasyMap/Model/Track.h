//
//  Track.h
//  EasyMap
//
//  Created by hyyy on 2017/3/15.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Realm/Realm.h>

@interface Track : RLMObject
/**
 经度
 */
@property (copy, nonatomic) NSString *longitude;
/**
 纬度
 */
@property (copy, nonatomic) NSString *latitude;
/**
 速度
 */
@property (copy, nonatomic) NSString *speed;
/**
 当前时间
 */
@property (strong, nonatomic) NSDate *currentDate;

@end
