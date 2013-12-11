//
//  MDLoadingCell.m
//  MDKit
//
//  Created by Matthew Dicembrino on 8/27/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDLoadingCell.h"

@implementation MDLoadingCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

@end
