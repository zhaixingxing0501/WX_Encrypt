//
//  ViewController.m
//  WX_Encrypt
//
//  Created by nucarf on 2019/11/22.
//  Copyright © 2019 nucarf. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#include <vector>
#import "WXMsgcrypt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *aesKeyStr = @"MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA=";
    NSString *sign = @"a988b82a2c1a4142fe5a16a785808f0713b73055";
    NSString *token = @"zkzdug1qcv07ATvNMf7";
    NSString *timestamp = @"1575267495269";
    NSString *nonce = @"2393532321347722";
//    NSString *encryptStr = @"MsQLWZbkY7huxbycpM74J4huQoybFvAu6bzontUydMzN+7yhc9MC2xS5dUCmtHvM8RVIyUfXPLV/1kHZ4S7hxA==";
//    NSData *encryptData = [encryptStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *receiveId = @"wjyapp";
    NSString *string = @"测试测试测试1234567890123132434434343412345678901231324344343434121234567890123132434434343412345678901231324344343434123456789012313243443434341234567890123132434434343412345678901231324344343434123456789012313243443434341234567890123132434434343412345678901231324344343434123456789012313243443434341234567890123132434434343456789012313243443434341234567890123132434434343412345678901231324344343434";
    
    //加密参数
//    NSString *timestamp = [WXMsgcrypt getNowTimeTimestamp];
//    NSString *nonce = [WXMsgcrypt getRandomStringWithNum:16];
    //密文消息
 
//    NSString *msg_encrypt = [WXMsgcrypt EncryptMsgWithReceiveId:receiveId sNonce:nonce sKey:aesKeyStr sEncrypt:string];
    NSString *msg_encrypt = @"VYrIGnrXLma/kwR64v2vs5olYI0dm2qZP+F+YUIIhDe8vN5UaeepfWF80K5ixPO72a0HuRLG6G08beeMVg6Pjbo3ZbiDJ/Pq/SXbZCQUg3l1WsUdpa/0z3yOVl9n/mQU+kj8fMOsbXp/tLR7bCKDWicNvDDI0pY82CHnyBtKZpxuX8h0ujfP7ed9o++nuFc7FOPF5s7Do58DVzDEKDuTIw===";

//    NSString *signature = [WXMsgcrypt getSignatureVerificationWithToken:token sTimeStamp:timestamp sNonce:nonce sEncrypt:msg_encrypt];
  
    NSString *result = [WXMsgcrypt DecryptMsgWithToken:token sTimeStamp:timestamp sNonce:nonce sKey:aesKeyStr sSgin:sign sEncrypt:msg_encrypt];

    
//    NSString *rets = [WXMsgcrypt DecryptMsgWithToken:token sTimeStamp:timestamp sNonce:nonce sKey:aesKeyStr sSgin:sign sEncrypt:encryptStr];
//      NSLog(@"__%@", rets);

    
  
//    NSString *rets1 = [WXMsgcrypt EncryptMsgWithReceiveId:token sTimeStamp:timestamp sNonce:nonce sKey:aesKeyStr sSgin:sign sEncrypt:string];

    //签名校验
//    NSString *dev_msg_signature = [NSString stringWithFormat:@"%@%@%@%@", token, token, nonce, aesKeyStr];
//
//    NSData *dev_data = [dev_msg_signature dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *dev_bytes = (Byte *)[dev_data bytes];
//    [self shellSort:dev_bytes length:(int)dev_data.length];
//    NSString *str2 =[[ NSString alloc] initWithData:dev_data encoding:NSUTF8StringEncoding];
//    NSMutableArray* sort = [NSMutableArray arrayWithObjects:token, nonce, timestamp, encryptStr, nil];
//
//    [sort sortUsingSelector:@selector(compare:)];
//     NSString *str2 = [NSString stringWithFormat:@"%@%@%@%@", sort[0], sort[1], sort[2], sort[3]];
//    NSLog(@"排序后:%@", str2);
//    NSString *sortStr = [[str2 dataUsingEncoding:NSUTF8StringEncoding] sha1];
//    BOOL ret = [sortStr isEqualToString:sign];
  
    
//        NSString* aa = @"aa";
//        NSData *d = [aa dataUsingEncoding:NSUTF8StringEncoding];
//        NSData *ed = [d AES256EncryptWithKey:@"00000000000000000000000000000000" iv:@"0000000000000000"];
//        ed = [ed AES256DecryptWithKey:@"00000000000000000000000000000000" iv:@"0000000000000000"];
//        NSString* sss =[[NSString alloc] initWithData:ed encoding:NSUTF8StringEncoding];
//
//
    
    
    
    //解密
//    NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:aesKeyStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:@"jWmYm7qr5nMoAUwZRjGtBxmz3KA1tkAj3ykkR6q2B2C=" options:NSDataBase64DecodingIgnoreUnknownCharacters];
//
//    void *byteArr =  (Byte *)[aesKey bytes];
//    NSData * ivdata = [[NSData alloc] initWithBytes:byteArr length:16];
//    NSString *ivStr = [[NSString alloc] initWithData:ivdata encoding:NSUTF8StringEncoding];
//    NSString *aesStr = [[NSString alloc] initWithData:aesKey encoding:NSUTF8StringEncoding];
    
//    NSData *d = [[NSData alloc] initWithBase64EncodedString:@"RypEvHKD8QQKFhvQ6QleEB4J58tiPdvo+rtK1I9qca6aM/wvqnLSV5zEPeusUiX5L5X/0lWfrf0QADHHhGd3QczcdCUpj911L3vg3W/sYYvuJTs3TUUkSUXxaccAS0qhxchrRYt66wiSpGLYL42aM6A8dTT+6k4aSknmPj48kzJs8qLjvd4Xgpue06DOdnLxAUHzM6+kDZ+HMZfJYuR+LtwGc2hgf5gsijff0ekUNXZiqATP7PF5mZxZ3Izoun1s4zG4LUMnvw2r+KqCKIw+3IQH03v+BCA9nMELNqbSf6tiWSrXJB3LAVGUcallcrw8V2t9EL4EhzJWrQUax5wLVMNS0+rUPA3k22Ncx4XXZS9o0MBH27Bo6BpNelZpS+/uh9KsNlY6bHCmJU9p8g7m3fVKn28H3KDYA5Pl/T8Z1ptDAVe0lXdQ2YoyyH2uyPIGHBZZIs2pDBS8R07+qN+E7Q==" options:NSDataBase64DecodingIgnoreUnknownCharacters];
//



}



@end
