//
//  LeTestMusicView.m
//  Walle
//
//  Created by 飞 刘 on 16/4/14.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LeTestMusicView.h"
#import "LeMusicTableCell.h"
#import "LeMediaManager.h"
#import "LeAudioPlayer.h"
#import "LePlayBarView.h"
#import "LePlayMusicViewController.h"

@interface LeTestMusicView ()<UITableViewDelegate, UITableViewDataSource, LePlayCommand>
@property (nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic) UIView* tableHeaderView;
@property (nonatomic) UIImageView* imageView;

@property (nonatomic) NSInteger headerHight;

@property (nonatomic) IBOutlet LePlayBarView* playbar;

@property (nonatomic) LeMediaManager* mediaManager;

@end

static NSString* CELL_IDENTIFIER = @"music_cell_identifier";

@implementation LeTestMusicView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

-(void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"LeMusicTableCell" bundle:nil]  forCellReuseIdentifier:CELL_IDENTIFIER];
    
    self.imageView.image=[UIImage imageNamed:@"Music_Header_image"];
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.tableHeaderView addSubview:self.imageView];
    self.tableView.tableHeaderView=self.tableHeaderView;
    
    self.playbar.playDelegate = self;

}

-(void)dealloc{
    self.playbar.playDelegate = nil;
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.tableView.bounds.size.width, 128)];
    }
    return _tableHeaderView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 128)];
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.clipsToBounds=YES;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

-(LeMediaManager *) mediaManager{
    return [LeMediaManager manager];
}

-(void)loadData{
    [self.mediaManager loadData:^(NSInteger retCode) {
        if (retCode == 0) {
            [self.tableView reloadData];
        }else{
            NSLog(@"load data error, code:%lD", (long)retCode);
        }
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mediaManager.listenArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeMusicTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if(!cell){
        cell = [[LeMusicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    SingleModel *singModel = [self.mediaManager.listenArray objectAtIndex:indexPath.row];

    [cell setSingleModel:singModel];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[LeAudioPlayer player] setPlayList:self.mediaManager.listenArray];
    [[LeAudioPlayer player] playIndex:indexPath.row];
    
//    SingleModel *singModel = [self.mediaManager.listenArray objectAtIndex:indexPath.row];
//    
//    
//    [self.mediaManager loadMediaPlayData:singModel complete:^(NSInteger retCode) {
//        [[LeAudioPlayer player] pushMedia:singModel];
//        [[LeAudioPlayer player] play];
//    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect =self.tableHeaderView.frame;
        rect.origin.y = offset.y;
        rect.size.height =CGRectGetHeight(rect)-offset.y;
        self.imageView.frame = rect;
        self.tableHeaderView.clipsToBounds=NO;
    }
}

- (UIViewController *)viewController {
    /// Finds the view's view controller.
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    
    // If the view controller isn't found, return nil.
    return nil;
}

#pragma mark LePlayCommand
-(void) playClick{
    [[LeAudioPlayer player] play];
}

-(void) nextClick{
    [[LeAudioPlayer player] playNext];
}

-(void) favorityClick{
    
}

-(void) itemClick{
    LePlayMusicViewController* viewController = [[LePlayMusicViewController alloc] initWithNibName:@"LePlayMusicViewController" bundle:nil];
    
    [[self viewController] presentViewController:viewController  animated:YES completion:nil];
}
@end
