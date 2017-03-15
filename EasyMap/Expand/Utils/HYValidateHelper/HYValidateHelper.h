//
//  HYValidateHelper.h
//  EasyMap
//
//  Created by hyyy on 2017/3/15.
//  Copyright © 2017年 hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYValidateHelper : NSObject

/**
 校验手机号

 @param phoneNumber 手机号
 @return 是否符合要求
 */
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;

/**
 校验邮箱

 @param email 邮箱
 @return 是否符合要求
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 校验用户身份证

 @param idCard 身份证号码
 @return 是否符合要求
 */
+ (BOOL)validateUserIdCard:(NSString *)idCard;

/**
 校验url

 @param url url
 @return 是否符合要求
 */
+ (BOOL)validateUrl:(NSString *)url;

@end
