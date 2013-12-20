//
//  MDPlayer.h
//  MDKit
//
//  Created by Matthew Dicembrino on 12/20/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class MDPlayerView;

typedef  NS_ENUM(NSInteger, MDPlayerState) {
    MDPlayerStatePaused,
    MDPlayerStatePlaying,
    MDPlayerStateFinished
};

@interface MDPlayer : NSObject {
    NSInteger _index;
}

@property (nonatomic, copy) void (^ didChangeState)(MDPlayerState state);
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (nonatomic) MDPlayerState currentState;

+ (MDPlayer *)sharedPlayer;

- (void)changePlayerState:(MDPlayerState)state;

- (void)play;
- (void)pause;
- (void)fastForward;
- (void)rewind;

- (void)loadFile:(NSURL *)fileURL inView:(MDPlayerView *)view;
- (void)changeVolume:(CGFloat)volume;

@end
