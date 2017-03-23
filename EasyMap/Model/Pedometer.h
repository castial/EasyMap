//
//  Pedometer.h
//  EasyMap
//
//  Created by hyyy on 2017/3/23.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Realm/Realm.h>

@interface Pedometer : RLMObject

@property (nonatomic, strong) NSDate *dayDate;
@property (nonatomic, assign) NSInteger stepCount;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger floorsAscended;    // 上楼
@property (nonatomic, assign) NSInteger floorsDescended;   // 下楼

@end
