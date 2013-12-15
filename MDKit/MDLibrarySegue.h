//
//  MDLibrarySegue.h
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *MDLibrarySegueIdentifier = @"MDLibrarySegue";

@interface MDLibrarySegue : UIStoryboardSegue

@property (assign, getter = isUnwinding) BOOL unwind;

@end
