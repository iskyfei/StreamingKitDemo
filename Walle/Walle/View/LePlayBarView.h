//
//  LePlayBarView.h
//  Walle
//
//  Created by 飞 刘 on 16/4/12.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LePlayCommand;

IB_DESIGNABLE
@interface LePlayBarView : UIControl

@property (nonatomic) IBInspectable NSString* mediaName;
@property (nonatomic) IBInspectable NSString* mediaDesc;

@property (nonatomic, assign) IBInspectable CGFloat progress;
@property (nonatomic, assign) IBInspectable BOOL favorite;

@property (nonatomic) IBInspectable UIColor* favoriteColor;
@property (nonatomic) IBInspectable UIColor* nonfavoriteColor;

@property (nonatomic) IBInspectable UIColor* buttonColor;


@property (nonatomic) IBOutlet UIButton* playBtn;
@property (nonatomic) IBOutlet UIButton* nextBtn;
@property (nonatomic) IBOutlet UIButton* favoriteBtn;
@property (nonatomic) IBOutlet UILabel*  mediaNameLab;
@property (nonatomic) IBOutlet UILabel*  mediaDescLab;
@property (nonatomic) IBOutlet UIProgressView* progressView;
@property (nonatomic) IBOutlet UIButton* mediaIcon;

@property (nonatomic, weak) id<LePlayCommand> playDelegate;


@end

@protocol LePlayCommand <NSObject>

-(void) playClick;
-(void) nextClick;
-(void) favorityClick;
-(void) itemClick;


@end
