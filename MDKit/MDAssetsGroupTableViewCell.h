//
//  MDAssetsGroupTableViewCell.h
//  Slide
//
//  Created by Matthew Dicembrino on 12/12/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDAssetsGroupTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

- (IBAction)unwindtoAssetsGroup:(UIStoryboardSegue *)segue;

@end
