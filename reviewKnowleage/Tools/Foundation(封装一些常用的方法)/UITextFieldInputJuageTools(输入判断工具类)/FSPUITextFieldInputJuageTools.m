//
//  FSPUITextFieldInputJuageTools.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPUITextFieldInputJuageTools.h"
#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define MAIL  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@"

@implementation FSPUITextFieldInputJuageTools


///shouldChangeCharactersInRange 使用
+ (BOOL)juageNumberOrCharacter:(NSString*)str {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [str isEqualToString:filtered];
}
///shouldChangeCharactersInRange 使用
+ (BOOL)juageNumber:(NSString*)str {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [str isEqualToString:filtered];
}

///
+ (BOOL)juageIsValidateEmail:(NSString *)email {
    //    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //    return [emailTest evaluateWithObject:email];
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MAIL] invertedSet];
    NSString *filtered = [[email componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [email isEqualToString:filtered];
}




/** 判断手机号码格式是否正确 */
+(BOOL)phoneNumberIsTrue:(NSString *)phoneNumber {
    {
        if ([phoneNumber length] == 0) {
            return NO;
        }
        
        NSString *regex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNumber];
        if (!isMatch) {
            return NO;
        }
        return YES;
    }
}
//密码必须包含大小写字母和数字
+(BOOL)secretTypeIsTrue:(NSString *)secret {
    
    if ([secret length] == 0) {
        return NO;
    }
    
    NSString * Regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL sIsMatch = [pred evaluateWithObject:secret];
    if (!sIsMatch) {
        return NO;
    }
    return YES;
    
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
/// 显示输入中文
+ (BOOL)JudgeInputChinese:(NSString *)content {
    NSString *regex = @"[\\u4e00-\\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([pred evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
}
//身份证格式判断
+(BOOL)JudgeidCardId:(NSString *)idCard
{
    //长度不为18的都排除掉
    if (idCard.length!=18) {
        return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:idCard];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[idCard substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [idCard substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}



@end
