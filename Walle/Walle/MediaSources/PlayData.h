//
//  PlayData.h
//  XiaoBao_Paper
//
//  Created by dllo on 15/10/5.
//  Copyright (c) 2015年 赵庆文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayData : NSObject
@property (nonatomic, copy) NSString *albumTitle; // 专辑名称

@property (nonatomic, copy) NSString *playUrl32;

@property (nonatomic, copy) NSString *richIntro; // 信息

@property (nonatomic, copy) NSString *coverSmall; // 图片(小)

@property (nonatomic, copy) NSString *playUrl64; // 播放url

@property (nonatomic, assign) NSInteger likes; // 喜欢人数

@property (nonatomic, retain) NSMutableArray *images; // 图片数组

@property (nonatomic, copy) NSString *coverLarge; // 图片(大)

@property (nonatomic, assign) NSInteger playtimes; // 播放次数

@property (nonatomic, copy) NSString *title; // 标题

@property (nonatomic, copy) NSString *intro; // 联系介绍

@property (nonatomic, copy) NSString *tags; // 标签

@property (nonatomic, assign) float duration;
@end
