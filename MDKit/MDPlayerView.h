//
//  MDPlayerView.h
//  MDKit
//
//  Created by Matthew Dicembrino on 12/20/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MDPlayerView : UIView

@property (nonatomic) AVPlayer *player;

- (void)setVideoGravityMode:(NSString *)gravityMode;

@end
