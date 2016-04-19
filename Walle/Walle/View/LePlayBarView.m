//
//  LePlayBarView.m
//  Walle
//
//  Created by 飞 刘 on 16/4/12.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LePlayBarView.h"
#import "LeAudioPlayer.h"
#import "UIButton+WebCache.h"

@interface LePlayBarView ()

-(IBAction)playMedia:(id)sender;

@property (nonatomic) NSTimer *myTimer;
@property (nonatomic, readonly) LeAudioPlayer * lePlayer;

@end

@implementation LePlayBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if(self = [super init]){
        [self loadViewFromNib];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder{

    if(self = [super initWithCoder:aDecoder]){
        [self loadViewFromNib];
    }
    
    return self;

}

-(void) loadViewFromNib{
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    
    NSArray * arr = [bundle loadNibNamed:@"LePlayBarView" owner:self options:nil];
    
    if (arr && arr.count > 0) {
//        return (LePlayBarView *)arr[0];
        LePlayBarView * view = (LePlayBarView*) arr[0];
        view.frame = self.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:arr[0]];
    }
//    return nil;
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)prepareForInterfaceBuilder{
    [self loadViewFromNib];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayHandler:) name:LE_PLAYER_STARTPLAY object:nil];
}

-(void) musicPlayHandler:(NSNotification *) notification{
    if (!self.myTimer) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updatePlayPanel) userInfo:nil repeats:YES];
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *  playBtnTxt = @"\U0000E964";
        
        [weakSelf.playBtn setTitle:playBtnTxt forState:UIControlStateNormal];
        
        NSURL * imageUrl = [NSURL URLWithString:weakSelf.lePlayer.currentMedia.coverSmall];
        [weakSelf.mediaIcon sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"PlayerDefaultIcon"]];
    });
}

-(void) updatePlayPanel{
    NSString * title = self.lePlayer.currentMedia.title;
    NSString * description = self.lePlayer.currentMedia.albumTitle;
    
    double duration = self.lePlayer.duration;
    double progress = self.lePlayer.progress;

    NSString * playBtnTxt = nil;
    
    if (!(self.lePlayer.playStatus & STKAudioPlayerStateRunning) || self.lePlayer.playStatus == STKAudioPlayerStatePaused) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        playBtnTxt =  @"\U0000E963";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mediaName = title;
        self.mediaDesc = description;
        self.progress = progress /duration;
        if (playBtnTxt) {
            [self.playBtn setTitle:playBtnTxt forState:UIControlStateNormal];
        }
        
    });
}

-(LeAudioPlayer *) lePlayer{
    return [LeAudioPlayer player];
}

-(NSString*) mediaName{
    return self.mediaNameLab.text;
}

-(void) setMediaName:(NSString *)mediaName{
    self.mediaNameLab.text = mediaName;
}

-(NSString*) mediaDesc{
    return self.mediaDescLab.text;
}

-(void) setMediaDesc:(NSString *)mediaDesc{
    self.mediaDescLab.text = mediaDesc;
}

-(CGFloat)progress{
    return self.progressView.progress;
}

-(void) setProgress:(CGFloat)progress{
    [self.progressView setProgress:progress];
}

-(void)setFavorite:(BOOL)favorite{
    UIColor * color = favorite?self.favoriteColor:self.nonfavoriteColor;
    [self.favoriteBtn setTitleColor:color forState:UIControlStateNormal];
    
    _favorite = favorite;
}

-(void)setFavoriteColor:(UIColor *)favoriteColor{
    _favoriteColor = favoriteColor;
    self.favorite = self.favorite;
}

-(void)setNonfavoriteColor:(UIColor *)nonfavoriteColor{
    _nonfavoriteColor = nonfavoriteColor;
    self.favorite = self.favorite;
}

-(void)setButtonColor:(UIColor *)buttonColor{
    _buttonColor = buttonColor;
    [self.playBtn setTitleColor:buttonColor forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:buttonColor forState:UIControlStateNormal];
}

-(IBAction)playMedia:(id)sender{
 
    if (self.playDelegate) {
        [self.playDelegate playClick];
    }
}

-(IBAction)addFavorite:(id)sender{
    if (self.playDelegate) {
        [self.playDelegate favorityClick];
    }
}

-(IBAction)nextMeida:(id)sender{
    if (self.playDelegate) {
        [self.playDelegate nextClick];
    }
}

-(IBAction)itemClick:(id)sender{
    if (self.playDelegate) {
        [self.playDelegate itemClick];
    }
}

@end
