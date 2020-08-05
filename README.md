# WX_Encrypt
企业微信API 加解密

msg_signature： 消息签名，用于验证请求是否来自企业微信（防止攻击者伪造）。
EncodingAESKey：用于消息体的加密，长度固定为43个字符，从a-z, A-Z, 0-9共62个字符中选取，是AESKey的Base64编码。解码后即为32字节长的AESKey

AESKey=Base64_Decode(EncodingAESKey + “=”)
AESKey：AES算法的密钥，长度为32字节。
AES采用CBC模式，数据采用PKCS＃7填充至32字节的倍数； IV初始向量大小为16字节，取AESKey前16字节
msg：为消息体明文，格式为XML
msg_encrypt：明文消息msg加密处理后的Base64编码。
