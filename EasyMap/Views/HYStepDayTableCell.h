//
//  HYStepDayTableCell.h
//  EasyMap
//
//  Created by hyyy on 2017/3/22.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pedometer;
@interface HYStepDayTableCell : UITableViewCell

+(NSString *)ID;

+(CGFloat)cellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) Pedometer *cellData;

@end
