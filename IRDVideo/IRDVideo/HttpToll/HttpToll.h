//
//  HttpToll.h
//  IRDTurbo
//
//  Created by 貟一凡 on 16/6/20.
//  Copyright © 2016年 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HttpToll : NSObject

+ (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

+ (void)POST:(NSString *)urlStr parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

+(void)downLoadWithUrlString:(NSString *)urlString;   //  下载

+(void)uploadWithUserUrlString:(NSString *)urlString upImg:(UIImage *)upImg success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;   //  上传

+(void)uploadMoneyImage:(NSString *)userId UrlString:(NSString *)urlString :(NSMutableArray *)arr;   //  上传多张图片

+(void)uploadOnlyOneWithUserUrlString:(NSString *)urlString upImg:(UIImage *)upImg success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;  //  上传单张照片

+(void)upLoadToUrlString:(NSString *)url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType  success:(void (^)( id responseObject))success failure:(void (^)( NSError *error))failure;   //  上传视频
@end
