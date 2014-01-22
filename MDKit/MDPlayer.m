//
//  MDPlayer.m
//  MDKit
//
//  Created by Matthew Dicembrino on 12/20/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDPlayer.h"
#import "MDPlayerView.h"

static const NSString *ItemStatusContext;

@interface MDPlayer ()

@end

@implementation MDPlayer

+ (MDPlayer *)sharedPlayer {
    static MDPlayer *_sharedPlayer;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlayer = [[MDPlayer alloc] init];
    });
    return _sharedPlayer;
}

- (void)loadFile:(NSURL *)fileURL inView:(MDPlayerView *)view {
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    NSString *tracksKey = @"tracks";
    
    [asset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:tracksKey]
                         completionHandler:^{
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                 NSError *error = nil;
                                 AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
                                 
                                 if (status == AVKeyValueStatusLoaded) {
                                     
                                     if (_playerItem != nil) {
                                         [self removeObservers];
                                         self.playerItem = nil;
                                     }
                                     
                                     self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
                                     [self.playerItem addObserver:self
                                                       forKeyPath:@"status"
                                                          options:0
                                                          context:&ItemStatusContext];
                                     
                                     if (_player != nil) {
                                         self.player = nil;
                                     }
                                     
                                     self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
                                     [_player setActionAtItemEnd:AVPlayerActionAtItemEndPause];
                                     [[NSNotificationCenter defaultCenter] addObserver:self
                                                                              selector:@selector(playerItemDidReachEnd:)
                                                                                  name:AVPlayerItemDidPlayToEndTimeNotification
                                                                                object:self.playerItem];
                                     [view setPlayer:self.player];
                                     _index++;
                                     
                                 } else {
                                     //Error
                                     NSLog(@"error: %@", error);
                                 }
                             });
                         }];
}

- (void)changeVolume:(CGFloat)volume {
    self.volume = volume;
    _player.volume = _volume;
}

- (void)play {
    [_player play];
    self.currentState = MDPlayerStatePlaying;
    [self initScrubberTimer];

}

- (void)pause {
    [_player pause];
    [self stopTimeObserver];
    self.currentState = MDPlayerStatePaused;
}

- (void)scrubStarted {
    [self pause];
}

- (void)scrubbedToSecond:(Float64)second {
    [_player seekToTime:CMTimeMakeWithSeconds(second, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self play];
}

- (void)eject {
    [self stopTimeObserver];
    [self removeObservers];
    self.playerItem = nil;
}

- (void)fastForward {
    [self pause];
    CGFloat seekSeconds = CMTimeGetSeconds(_player.currentTime) + 10;
    CGFloat durationSeconds = CMTimeGetSeconds(_playerItem.duration);
    if (seekSeconds <= durationSeconds - 10) {
        CMTime newTime = CMTimeMakeWithSeconds(seekSeconds, _player.currentTime.timescale);
       [_player seekToTime:newTime];
    } else {
        [_player seekToTime:_playerItem.duration toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
    [self play];
}

- (void)rewind {
    [self pause];
    [_player seekToTime:CMTimeMakeWithSeconds(CMTimeGetSeconds(_player.currentTime) - 10, _player.currentTime.timescale)];
    [self play];
}

#pragma mark - Private

- (void)removeObservers {
    //Remove KVO observing of the default player item
    [self.playerItem removeObserver:self forKeyPath:@"status" context:&ItemStatusContext];
    
    //Remove Notification observing of default player item
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.playerItem];
}

- (void)changeState:(MDPlayerState )state {
    if (self.didChangeState) {
        self.didChangeState(state);
    }
}

- (void)initScrubberTimer {
    if (!_timeObserver) {
        CMTime duration = [self playerItemDuration];
        if (CMTIME_IS_VALID(duration)) {
            Float64 seconds = CMTimeGetSeconds(duration);
            if (self.didSetDuration) {
                self.didSetDuration(seconds);
            }
            if (isfinite(seconds)) {
                __weak MDPlayer *weakSelf = self;
                _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(.1, NSEC_PER_SEC)
                                                                       queue:NULL
                                                                  usingBlock:^(CMTime time) {
                                                                      [weakSelf syncScrubber];
                                                                  }];
            }
        }
    }
}

- (void)stopTimeObserver {
    if (_timeObserver) {
        [_player removeTimeObserver:_timeObserver];
        _timeObserver = nil;
    }
}

- (CMTime)playerItemDuration {
	AVPlayerItem *playerItem = [self.player currentItem];
	if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
		return([playerItem duration]);
	}
	return(kCMTimeInvalid);
}

- (void)syncScrubber {
    CMTime duration = [self playerItemDuration];
	if (CMTIME_IS_VALID(duration)) {
        Float64 seconds = CMTimeGetSeconds([_player currentTime]);
        if (isfinite(seconds)) {
            if (self.didChangeTime) {
                self.didChangeTime(seconds);
            }
        }
	}
}

#pragma mark - AVPlayerItemNotifications

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self changeState:MDPlayerStateFinished];
    [_player seekToTime:kCMTimeZero];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (context == &ItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           //[self syncUI];
                       });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
    return;
}

@end