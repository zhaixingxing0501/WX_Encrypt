//
//  WXMsgcrypt.m
//  WX_Encrypt
//
//  Created by nucarf on 2019/11/22.
//  Copyright © 2019 nucarf. All rights reserved.
//

#import "WXMsgcrypt.h"
#import "NSData+AES.h"
#import "GTMBase64.h"

@implementation WXMsgcrypt


#pragma mark ---- 解密方法
+ (NSString *)DecryptMsgWithToken:(NSString *)token sTimeStamp:(NSString *)sTimeStamp sNonce:(NSString *)sNonce sKey:(NSString *)sKey sSgin:(NSString *)sSgin sEncrypt:(NSString *)sEncrypt {
    
    BOOL ret = [WXMsgcrypt signatureVerificationWithToken:token sTimeStamp:sTimeStamp sNonce:sNonce sSgin:sSgin sEncrypt:sEncrypt];
    
    if (ret) {
        NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:sKey options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        void *byteArr =  (Byte *)[aesKey bytes];
        NSData * ivdata = [[NSData alloc] initWithBytes:byteArr length:16];
        
        //解密APP加密的密文需要删除最后一个"="号
        if ([[sEncrypt substringFromIndex:sEncrypt.length-1] isEqualToString:@"="]) {
            sEncrypt = [sEncrypt substringToIndex:sEncrypt.length-1];
        }
        NSData *d = [[NSData alloc] initWithBase64EncodedString:sEncrypt options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSData *resuletData = [d AES256DecryptWithKey:(Byte *)byteArr iv:(Byte *)[ivdata bytes]];
        
        NSData *lengthData = [resuletData subdataWithRange:NSMakeRange(16, 4)];
        int len = [WXMsgcrypt byteWithInt:[lengthData bytes]];
        NSData *contentData =  [resuletData subdataWithRange:NSMakeRange(20, len)];
        NSString *resultStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
        return [[NSString alloc] initWithString:resultStr];
    }
    return @"";
}


#pragma mark ---- 加密方法
+ (NSString *)EncryptMsgWithReceiveId:(NSString *)receiveId sNonce:(NSString *)sNonce sKey:(NSString *)sKey sEncrypt:(NSString *)sEncrypt {
    
    
    NSData *data = [sEncrypt dataUsingEncoding:NSUTF8StringEncoding];
    int value = (int)data.length;
    //转换为4个字节
    Byte byteData[4] = {};
    byteData[0] =(Byte)((value & 0xFF000000)>>24);
    byteData[1] =(Byte)((value & 0x00FF0000)>>16);
    byteData[2] =(Byte)((value & 0x0000FF00)>>8);
    byteData[3] =(Byte)((value & 0x000000FF));
    
    NSData *lenData = [[NSData alloc] initWithBytes:byteData length:4];
    NSMutableData *resData = [NSMutableData dataWithData:[sNonce dataUsingEncoding:NSUTF8StringEncoding]];
    
    [resData appendData:lenData];
    [resData appendData:data];
    [resData appendData:[receiveId dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:sKey options:NSDataBase64DecodingIgnoreUnknownCharacters];
    void *byteArr =  (Byte *)[aesKey bytes];
    NSData *ivdata = [[NSData alloc] initWithBytes:byteArr length:16];
    NSData *encryptData = [resData AES256EncryptWithKey:byteArr iv:(Byte *)[ivdata bytes]];
    
    NSString *result = [encryptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSData *result1 = [GTMBase64 encodeData:encryptData];
 NSString *result3 = [GTMBase64 stringByEncodingData:encryptData];
    return [NSString stringWithFormat:@"%@=", result3];
}


#pragma mark -- 签名校验 --
+ (BOOL)signatureVerificationWithToken:(NSString *)token sTimeStamp:(NSString *)sTimeStamp sNonce:(NSString *)sNonce sSgin:(NSString *)sSgin sEncrypt:(NSString *)sEncrypt {
    
    NSString *result = [WXMsgcrypt getSignatureVerificationWithToken:token sTimeStamp:sTimeStamp sNonce:sNonce sEncrypt:sEncrypt];
    return [result isEqualToString:sSgin];
    
}

#pragma mark --  获取签名 --
+ (NSString *)getSignatureVerificationWithToken:(NSString *)token sTimeStamp:(NSString *)sTimeStamp sNonce:(NSString *)sNonce sEncrypt:(NSString *)sEncrypt {
    
    NSMutableArray* sort = [NSMutableArray arrayWithObjects:token, sNonce, sTimeStamp, sEncrypt, nil];
    [sort sortUsingSelector:@selector(compare:)];
    NSString *sortString = [sort componentsJoinedByString:@""];
    NSString *result = [[sortString dataUsingEncoding:NSUTF8StringEncoding] sha1];
    return result;
}


+ (NSString *)getRandomStringWithNum:(NSInteger)num {
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        
        int figure = arc4random() % 10;
        NSString *tempString = [NSString stringWithFormat:@"%d", figure];
        string = [string stringByAppendingString:tempString];
    }
    return string;
}


/// byte 转int
/// @param bytes byte数组
+ (int)byteWithInt:(nullable const void  *)bytes
{
    Byte *byte = (Byte *)bytes;
    int returnValue = 0;
    int byteCount = sizeof(byte)/2;
    for (int i=0; i<byteCount; i++) {
        if (i == 0) {
            returnValue = byte[byteCount -1];
        }else{
            returnValue += pow(256, i) * byte[byteCount-i-1];
        }
    }
    return returnValue;
}


+ (NSString *)getNowTimeTimestamp{
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}


@end
