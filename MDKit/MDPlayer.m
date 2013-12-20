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

- (void)loadFile:(NSURL *)fileURL inView:(UIView *)view {
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
                                     
                                     self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
                                     
                                     _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                                     [_playerLayer setFrame:view.bounds];
                                     [view.layer addSublayer:_playerLayer];
                                     
                                     _index++;
                                     
                                 } else {
                                     //Error
                                     NSLog(@"error: %@", error);
                                 }
                                 
                             });
                         }];
}

- (void)changeVolume:(CGFloat)volume {
    _player.volume = volume;
}

- (void)play {
    [_player play];
    self.currentState = MDPlayerStatePlaying;
}

- (void)pause {
    [_player pause];
    self.currentState = MDPlayerStatePaused;
}

- (void)fastForward {
    
}

- (void)rewind {
    
}

#pragma mark - Private

- (void)stop {
    [self pause];
}

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

#pragma mark - AVPlayerItemNotifications

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self changeState:MDPlayerStateFinished];
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

- (void)dealloc  {
    [self removeObservers];
}

@end