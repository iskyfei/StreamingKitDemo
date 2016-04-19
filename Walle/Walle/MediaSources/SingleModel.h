//
//  SingleModel.h
//  XiaoBao_Paper
//
//  Created by dllo on 15/10/3.
//  Copyright (c) 2015年 赵庆文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayData.h"

@interface SingleModel : NSObject
@property (nonatomic, assign) NSInteger trackId; // 用于下一接口数据接收使
@property (nonatomic, copy) NSString *playUrl64; // 播放地址
@property (nonatomic, copy) NSString *playUrl32;

@property (nonatomic, copy) NSString *title; // 标题

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *coverLarge;

@property (nonatomic, copy) NSString *smallLogo;

@property (nonatomic, copy) NSString *albumTitle;

@property (nonatomic, copy) NSString *refSmallLogo;

@property (nonatomic, retain) NSNumber *likes;

@property (nonatomic, retain) NSNumber *playtimes;

@property (nonatomic, strong) PlayData* playData;
@end
