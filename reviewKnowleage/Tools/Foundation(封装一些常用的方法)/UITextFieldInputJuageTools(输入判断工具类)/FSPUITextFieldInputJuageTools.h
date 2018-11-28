//
//  FSPUITextFieldInputJuageTools.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//  shouldChangeCharactersInRange 代理判断 输入类型显示 中文 字母 数字


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPUITextFieldInputJuageTools : NSObject

/** uitextfield 限制只能输入数字和字母的判断*/
+ (BOOL)juageNumberOrCharacter:(NSString*)str;
/** uitextfield 限制只能输入数字*/
+ (BOOL)juageNumber:(NSString*)str;
/**uitextfield 限制只能输入邮箱*/
+ (BOOL)juageIsValidateEmail:(NSString *)email ;



/** 判断手机号码格式是否正确 */
+ (BOOL)phoneNumberIsTrue:(NSString *)phoneNumber;
/** 判断密码输入类型 密码必须包含大小写字母和数字 */
+(BOOL)secretTypeIsTrue:(NSString *)secret;
/** 判断是否含有非法字符 */
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
/** 判断身份证是否合法*/
+ (BOOL)JudgeidCardId:(NSString *)idCard;
/** 判断只能输入汉字*/
+ (BOOL)JudgeInputChinese:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
