//
//  AmountUtil.m
//  UtilSDK
//
//  Created by willwang on 2019/3/6.
//  Copyright © 2019年 com.will. All rights reserved.
//

#import "FormatUtil.h"
#import "GlobalDefine.h"
#import "VeryfyUtil.h"
@implementation FormatUtil

//添加分位符
+(NSString *)amountWithComma:(NSString *)amtStr{
    
    if(IsStrEmpty(amtStr)) {
        return @"";
    }
    //符合金额格式
    NSString * regular = @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$";
    if (![VeryfyUtil regularVerfy:regular withStr:amtStr]) {
        return @"";
    }
    
    char a[30];
    bzero(a, sizeof(a));
    strcpy(a, [amtStr UTF8String]);
    
    char *p = strchr(a, '.');
    while (p!=NULL && (p=p-3) > a) {
        char *pend = a + strlen(a);
        memmove(p+1, p, (pend-p)*sizeof(char));
        *p = ',';
    }
    
    NSString *processedSTR = [NSString stringWithUTF8String:a];
    return processedSTR;
}

//单位转换
+(NSString *)transMoneyUnit:(NSString *)amount type:(int)type{
    
    if (type == 0) {
        //分转元
        NSString *regular = @"^[0-9]\\d*$";
        if (![VeryfyUtil regularVerfy:regular withStr:amount]) {
            return @"";
        }
        NSMutableString *amountStr = [[NSMutableString alloc]initWithString:amount];
        [amountStr insertString:@"." atIndex:(amountStr.length -1)];
        return amountStr;
    }else if(type == 1){
        //元转分
        
        NSString *regular1 = @"^[0-9]\\d*.\\d{2}$";
        NSString *regular2 = @"^[0-9]\\d*.\\d{1}$";
        NSString *regular3 = @"^[0-9]\\d*$";
        
        //带两位小数
        if ([VeryfyUtil regularVerfy:regular1 withStr:amount]) {
            amount = [amount stringByReplacingOccurrencesOfString:@"." withString:@""];
            return amount;
        }
        //带一位小数，补1零
        if ([VeryfyUtil regularVerfy:regular2 withStr:amount]) {
            
            amount = [NSString stringWithFormat:@"%@0",amount];
            amount = [amount stringByReplacingOccurrencesOfString:@"." withString:@""];
            return amount;
        }
        //纯整数，补2零
        if ([VeryfyUtil regularVerfy:regular3 withStr:amount]) {
            
            amount = [NSString stringWithFormat:@"%@00",amount];
            amount = [amount stringByReplacingOccurrencesOfString:@"." withString:@""];
            return amount;
        }
        
    }
    return @"";
}


//字符串加掩码
+ (NSString *)formatStringWithMask:(NSString *)string range:(NSRange )range Mask:(NSString *)mask{
    
//    NSString *regular = BANK_CARD_NO_RG;
//    if (![VeryfyUtil regularVerfy:regular withStr:cardNo]) {
//        return @"";
//    }
    //range 越界
    int rule = range.length + range.location;
    if (rule < 0 || rule > string.length) {
        return @"";
    }
    if (IsStrEmpty(string)) {
        return @"";
    }
    if (IsStrEmpty(mask)) {
        return @"";
    }
    
    NSMutableString *mCardNo = [string mutableCopy];
    [mCardNo replaceCharactersInRange:range withString:mask];
    
    return mCardNo;
}

//字符串加空格
+(NSString *) formatStringWithBlank:(NSString *)string SpaceNum:(int)space{
    
//    NSString *regular = BANK_CARD_NO_RG;
//    if (![VeryfyUtil regularVerfy:regular withStr:cardNo]) {
//        return @"";
//    }
    if (IsStrEmpty(string)) {
        return @"";
    }
    if (space <= 0) {
        return @"";
    }
    
    NSMutableString *mstring = [string mutableCopy];
    int blankIndex = space;
    while (blankIndex < mstring.length) {
        [mstring insertString:@" " atIndex:blankIndex];
        blankIndex = blankIndex + space + 1;
    }
    
    return mstring;
    
}

@end
