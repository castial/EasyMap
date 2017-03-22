//
//  HYStepDayTableCell.h
//  EasyMap
//
//  Created by hyyy on 2017/3/22.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYStepDayTableCell : UITableViewCell

+(NSString *)ID;

+(CGFloat)cellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (copy, nonatomic) NSDictionary *cellData;

@end
