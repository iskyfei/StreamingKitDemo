//
//  LeAudioPlayer.m
//  Walle
//
//  Created by 飞 刘 on 16/4/13.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LeAudioPlayer.h"
#import "LeMediaManager.h"



@interface LeAudioPlayer ()<STKAudioPlayerDelegate>


@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSMutableArray* mediaList;
@property (nonatomic) STKAudioPlayer* stkPlayer;
@end

@implementation LeAudioPlayer

NSString * const LE_PLAYER_STARTPLAY = @"Le_Player_Start_Play";

+(instancetype)player{
    static LeAudioPlayer* _player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _player = [[LeAudioPlayer alloc] init];
    });
    
    return _player;
}

-(instancetype) init{
    self = [super init];
    if(self){
        self.currentIndex = 0;
        self.mediaList = [[NSMutableArray alloc] init];
        self.stkPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = YES, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
        
        self.stkPlayer.delegate = self;
        self.stkPlayer.volume = 0.5;
    }
    return self;
}

-(double)duration{
    return self.stkPlayer.duration;
}

-(double)progress{
    return self.stkPlayer.progress;
}

-(SingleModel*)currentMedia{
    @synchronized (self) {
        if (self.currentIndex < self.mediaList.count) {
            return self.mediaList[self.currentIndex];
        }
        return nil;
    }
}

-(NSUInteger) pushMedia:(SingleModel *) media{
    @synchronized (self) {
        [self.mediaList addObject:media];
        return self.mediaList.count -1;
    }
}

-(void) setPlayList:(NSArray *) mediaArray{
    @synchronized (self) {
        [self.mediaList removeAllObjects];
        [self.mediaList addObjectsFromArray:mediaArray];
    }
}

-(void) play{
    @synchronized (self) {
        if (self.mediaList.count < 1) {
            return;
        }
        
        if (self.stkPlayer.state & STKAudioPlayerStateRunning) {
            if (self.stkPlayer.state == STKAudioPlayerStatePaused) {
                [self.stkPlayer resume];
            }else{
                [self.stkPlayer pause];
            }
        }else{
            [self playIndex:self.currentIndex];
        }
    }
    
}

-(void)playNext{
    NSUInteger index = self.currentIndex + 1;
    [self playIndex:index];
}

-(void)playLast{
    @synchronized (self) {
        if (self.mediaList.count <1) {
            return;
        }
        NSInteger index = self.currentIndex - 1;
        if (index<0) {
            index = self.mediaList.count -1;
        }
        [self playIndex:index];
    }
}

-(void) playIndex:(NSUInteger) index{
    @synchronized (self) {
        NSUInteger playIndex = index;
        
        if (playIndex >= self.mediaList.count) {
            playIndex = self.mediaList.count -1;
        }
        
        SingleModel* music = self.mediaList[playIndex];
        
         self.currentIndex = playIndex;
        
        if (music.playData) {
            [self.stkPlayer play:music.playData.playUrl64];
        }else{
            __weak __typeof(self) weakSelf = self;
            [[LeMediaManager manager] loadMediaPlayData:music complete:^(NSInteger retCode) {
                if (weakSelf.currentIndex == playIndex) {
                    [self.stkPlayer play:music.playData.playUrl64];
                }
            }];
        }
    }
}


//STKAudioPlayerStateReady,
//STKAudioPlayerStateRunning = 1,
//STKAudioPlayerStatePlaying = (1 << 1) | STKAudioPlayerStateRunning,
//STKAudioPlayerStateBuffering = (1 << 2) | STKAudioPlayerStateRunning,
//STKAudioPlayerStatePaused = (1 << 3) | STKAudioPlayerStateRunning,
//STKAudioPlayerStateStopped = (1 << 4),
//STKAudioPlayerStateError = (1 << 5),
//STKAudioPlayerStateDisposed = (1 << 6)


-(STKAudioPlayerState) playStatus{
    return self.stkPlayer.state;
}


-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId
{
    //NSLog(@"完成缓冲");
}

-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    //NSLog(@"完成播放");
    
    
}

-(void)audioPlayer:(STKAudioPlayer *)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    if (state == STKAudioPlayerStateStopped) {
//        [self nextButtonAction];
    }
    if (state == STKAudioPlayerStatePlaying) {
      [[NSNotificationCenter defaultCenter] postNotificationName:LE_PLAYER_STARTPLAY object:nil];
        
    }
    
    //NSLog(@"开始改变");
}
-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LE_PLAYER_STARTPLAY object:nil];
}
-(void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    
    //NSLog(@"离开");
}


@end
