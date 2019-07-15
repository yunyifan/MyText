//
//  HttpToll.m
//  IRDTurbo
//
//  Created by 貟一凡 on 16/6/20.
//  Copyright © 2016年 貟一凡. All rights reserved.
//

#import "HttpToll.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "HttpManager.h"
#import "MBProgressHUD+MJ.h"

#define CustomErrorDomain @"com.ard.rea chabilityTest"


@implementation HttpToll

typedef enum {
    
    XDefultFailed = -1000,
    
    XRegisterFailed,
    
    XConnectFailed,
    
    XNotBindedFailed
    
}CustomErrorFailed;

static Reachability *reach;

+(HttpManager *)manager
{
    HttpManager *manager = [HttpManager manager];
    // 超时时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setTimeoutInterval:8];
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    AFJSONResponseSerializer*response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    

        manager.responseSerializer = response; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}
+ (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    NSLog(@"请求的参数 %@",parameters);
    BOOL reachabilityFlag = [self reachabilityChanged];
    
    if (!reachabilityFlag) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请检查网络连接状况" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XConnectFailed userInfo:userInfo];
        
        failure(aError);
        
        [MBProgressHUD showError:@"请检查网络连接状况"];
        return;
    }
    
    
    AFHTTPSessionManager *manager = [self manager];
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    //  数据请求的进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if(responseObject){
               

//               NSDictionary *dic =
//              [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                      success(responseObject);
    }else{
        
                success(@{@"masg":@"暂无数据"});
         }
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
    
                NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
    
                failure(aError);

}];
}

+ (void)POST:(NSString *)urlStr parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    NSLog(@"请求的参数 %@",params);

    BOOL reachabilityFlag = [self reachabilityChanged];

    if (!reachabilityFlag) {

        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请检查网络连接状况" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XConnectFailed userInfo:userInfo];
        
        failure(aError);
        
        [MBProgressHUD showError:@"请检查网络连接状况"];

        return;
    }
    
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //请求进程
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
//            NSData *jsonData = [responseObject 服从现场dataUsingEncoding:NSUTF8StringEncoding];
            

//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            success(responseObject);
        }else{
            
            success(@{@"masg":@"暂无数据"});
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        
        failure(aError);
        

    }];

}
//   下载
+(void)downLoadWithUrlString:(NSString *)urlString
{
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
    }];
    // 5.启动下载任务
    [task resume];
}
//   长传     对象类型
+(void)uploadWithUserUrlString:(NSString *)urlString upImg:(UIImage *)upImg success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *imageData = UIImageJPEGRepresentation(upImg,0.5);
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         
         avatar   uid   token    传入的参数
         */
//        NSData*data1 = UIImageJPEGRepresentation(upImg, 0.2);
        // 拼接数据到请求题中
        NSString *userId = [NSString stringWithFormat:@"%@",@""];
        NSString *userToken = [NSString stringWithFormat:@"%@",@""];
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"head.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFormData:[userId dataUsingEncoding:NSUTF8StringEncoding] name:@"uid"];
        [formData appendPartWithFormData:[userToken dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
//        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSDictionary *dic = responseObject;
        success(dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        
        failure(aError);
        

    }];
}
+(void)uploadMoneyImage:(NSString *)userId UrlString:(NSString *)urlString :(NSMutableArray *)arr{
 
 //   服务器提交图片
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *param = @{@"uid":@""};

    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传 多张图片
        for(NSInteger i = 0; i < arr.count; i++)
        {
            NSData * imageData = [arr objectAtIndex: i];
            // 上传的参数名
            NSString * Name = [NSString stringWithFormat:@"%@%zi", userId, i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"完成 %@", result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误 %@", error.localizedDescription);

    }];

}
//   长传   file 类型的
+(void)uploadOnlyOneWithUserUrlString:(NSString *)urlString upImg:(UIImage *)upImg success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    NSDictionary *param = @{@"":@""};
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        //        NSData*data1 = UIImageJPEGRepresentation(upImg, 0.2);
        // 拼接数据到请求题中
        [formData appendPartWithFileData:data name:@"image" fileName:@"share.png" mimeType:@"image/png"];
        //        ******* 2.通过路径上传沙盒或系统相册里的图片 ****
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:userId] name:@"file" fileName:@"head.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        //        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"image" object:dic];
        NSDictionary *dic = responseObject;
        success(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：");
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        
        failure(aError);
        
        
    }];
}
//  视频上传
+ (void)upLoadToUrlString:(NSString *)url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType  success:(void (^)( id responseObject))success failure:(void (^)( NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success( responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure( error);
        }
    }];
    
}
+(void)cancleRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];

    
}
+ (void)load
{
    // 判断能否连接到某一个主机
    // http://www.baidu.com
    reach = [Reachability reachabilityWithHostName:@"baidu.com"];
    
}

+(BOOL)reachabilityChanged
{
    // 状态
    if (reach.currentReachabilityStatus == NotReachable) return 0;
    
    return 1;
    
}

@end
