//
//  Contact.h
//  EasyMap(联系人模型)
//
//  Created by hyyy on 2017/3/10.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Realm/Realm.h>

@interface Contact : RLMObject

/**
 联系人姓名
 */
@property (copy, nonatomic) NSString *contactName;
/**
 联系人手机号
 */
@property (copy, nonatomic) NSString *contactPhone;
/**
 联系人是否被选中
 */
@property (assign, nonatomic) BOOL isSelected;

@end
