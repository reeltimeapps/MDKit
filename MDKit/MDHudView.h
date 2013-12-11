//
//  MDHudView.h
//  HMY
//
//  Created by Matthew Dicembrino on 9/14/12.
//  Copyright (c) 2012 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDHudView : UIView

/*
 The label to display our message text
 */
@property (strong, nonatomic) UILabel *textLabel;

/*
 Creates and returns a new HudView
 @param view The view in which to display the HudView
 @param title The text to be displayed in textLabel.
 */
+ (MDHudView *)showHudInView:(UIView *)view title:(NSString *)title;

- (void)hide;

@end
