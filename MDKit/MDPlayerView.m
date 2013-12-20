//
//  MDPlayerView.m
//  MDKit
//
//  Created by Matthew Dicembrino on 12/20/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDPlayerView.h"

@implementation MDPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (void)setVideoGravityMode:(NSString *)gravityMode {
	AVPlayerLayer *layer = (AVPlayerLayer*)[self layer];
	layer.videoGravity = gravityMode;
}


@end
