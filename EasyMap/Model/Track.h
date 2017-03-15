//
//  Track.h
//  EasyMap
//
//  Created by hyyy on 2017/3/15.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Realm/Realm.h>

@interface Track : RLMObject

@property (copy, nonatomic) NSString *longitude;

@property (copy, nonatomic) NSString *latitude;

@property (copy, nonatomic) NSString *speed;

@property (strong, nonatomic) NSDate *currentDate;

@end
