//
//  MDAssetsGroupTableViewCell.m
//   MDKit
//
//  Created by Matthew Dicembrino on 12/12/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import "MDAssetsGroupTableViewCell.h"

@implementation MDAssetsGroupTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      //  [self setupCustomFonts];
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)unwindtoAssetsGroup:(UIStoryboardSegue *)segue {
    
}
@end
