//
//  WXMsgcrypt.h
//  WX_Encrypt
//
//  Created by nucarf on 2019/11/22.
//  Copyright © 2019 nucarf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMsgcrypt : NSObject


/// 解密方法
/// @param token token
/// @param sTimeStamp 时间戳
/// @param sNonce sNonce
/// @param sKey key
/// @param sSgin sgin
/// @param sEncrypt 加密字符传
+ (NSString *)DecryptMsgWithToken:(NSString *)token sTimeStamp:(NSString *)sTimeStamp sNonce:(NSString *)sNonce sKey:(NSString *)sKey sSgin:(NSString *)sSgin sEncrypt:(NSString *)sEncrypt ;


/// 加密方法
/// @param receiveId receiveId
/// @param sNonce sNonce
/// @param sKey key
/// @param sEncrypt 加密字符传
+ (NSString *)EncryptMsgWithReceiveId:(NSString *)receiveId sNonce:(NSString *)sNonce sKey:(NSString *)sKey sEncrypt:(NSString *)sEncrypt ;


/// 获取签名
/// @param token token
/// @param sTimeStamp 时间戳
/// @param sNonce 16位随机数
/// @param sEncrypt 密文
+ (NSString *)getSignatureVerificationWithToken:(NSString *)token sTimeStamp:(NSString *)sTimeStamp sNonce:(NSString *)sNonce sEncrypt:(NSString *)sEncrypt;

/// 随机字符串
/// @param num 长度
+ (NSString *)getRandomStringWithNum:(NSInteger)num;

/// 获取当前时间戳 (毫秒)
+ (NSString *)getNowTimeTimestamp;


@end

NS_ASSUME_NONNULL_END
