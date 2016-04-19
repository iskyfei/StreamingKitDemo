//
//  LeMediaManager.m
//  Walle
//
//  Created by 飞 刘 on 16/4/14.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LeMediaManager.h"
#import "AFNetworking.h"
#import "SingleModel.h"

@interface LeMediaManager ()


@end


@implementation LeMediaManager

+(instancetype)manager{
   static LeMediaManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[LeMediaManager alloc] init];
    });
    return _manager;
}

-(instancetype)init{
    self = [super init];
    if (self){
        self.listenArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) loadData:(void(^)(NSInteger))completeBlock{
    
    NSString * sourceUrl = @"http://mobile.ximalaya.com/mobile/others/ca/album/track/321797/true/1/30?device=iPhone";
  
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    AFHTTPSessionManager* afManager = [AFHTTPSessionManager manager];
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    
    [afManager GET:sourceUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [netWorkManager stopMonitoring];

        NSMutableDictionary *dictionary = responseObject;
        
        NSMutableDictionary *dictionary2 = [dictionary objectForKey:@"tracks"];
        NSMutableArray *array = [dictionary2 objectForKey:@"list"];
        for (NSMutableDictionary *dic in array) {
            SingleModel *model = [[SingleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            //这个ID播放不了
            if (model.trackId != 8637243) {
                
                [self.listenArray addObject:model];
            }
            //            [model release];
        }
        [self.listenArray removeLastObject];//最后一个元素没图片 删除

        completeBlock(0);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(error.code);
    }];
}


-(void) loadMediaPlayData:(SingleModel *) singleModel complete:(void(^)(NSInteger retCode)) completeBlock{
    NSString *sourceUrl = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%ld", singleModel.trackId];
    
//    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    AFHTTPSessionManager* afManager = [AFHTTPSessionManager manager];
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    
    [afManager GET:sourceUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dictionary = responseObject;
        PlayData *playData = [[PlayData alloc] init];
        [playData setValuesForKeysWithDictionary:dictionary];
        singleModel.playData = playData;

        completeBlock(0);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(error.code);
    }];
}
@end
