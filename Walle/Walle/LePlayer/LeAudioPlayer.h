//
//  LeAudioPlayer.h
//  Walle
//
//  Created by 飞 刘 on 16/4/13.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import "STKAudioPlayer.h"

#import "SingleModel.h"

extern NSString * const LE_PLAYER_STARTPLAY;



@interface LeAudioPlayer : NSObject

+(instancetype)player;

@property (nonatomic) STKAudioPlayerState playStatus;

@property (nonatomic) double  duration;
@property (nonatomic) double  progress;
@property (nonatomic,readonly) SingleModel* currentMedia;


-(NSUInteger) pushMedia:(SingleModel *) media;

-(void) setPlayList:(NSArray *) mediaArray;

-(void) play;

-(void) playNext;

-(void) playLast;

-(void) playIndex:(NSUInteger ) index;
@end
