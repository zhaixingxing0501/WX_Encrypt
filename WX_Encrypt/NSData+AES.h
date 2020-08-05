//
//  NSData+AES.h
//
//  Created by Wu,Bin on 2018/9/27.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)


/// AES128加密
/// @param key key
/// @param iv iv初始向量
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

/// AES128解密
/// @param key key
/// @param iv iv初始向量
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

/// AES256加密
/// @param key key
/// @param iv iv初始向量
- (NSData *)AES256EncryptWithKey:(const void *)key iv:(const void *)iv;

/// AES256解密
/// @param key key
/// @param iv iv初始向量
- (NSData *)AES256DecryptWithKey:(const void *)key iv:(const void *)iv;

- (NSString*) sha1;

@end
