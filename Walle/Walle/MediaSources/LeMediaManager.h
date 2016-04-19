//
//  LeMediaManager.h
//  Walle
//
//  Created by 飞 刘 on 16/4/14.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleModel.h"

@interface LeMediaManager : NSObject

+(instancetype) manager;

@property (nonatomic) NSMutableArray* listenArray;

-(void) loadData:(void(^)(NSInteger retCode))completeBlock;

-(void) loadMediaPlayData:(SingleModel *) singleModel complete:(void(^)(NSInteger retCode)) completeBlock;
@end
