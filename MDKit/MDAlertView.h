//
//  MDAlertView.h
//  MDKit
//
//  Created by Matthew Dicembrino on 2012-07-31.
//  Copyright (c) 2012 Matthew Dicembrino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDAlertView : UIView

/*
 The label to display our message text
 */
@property (strong, nonatomic) UILabel *textLabel;

/*
 Creates and returns a new Alertview
 @param view The view in which to display the AlertView
 @param message The text to be displayed in textLabel.
 */
+ (MDAlertView *)showAlertInView:(UIView *)view message:(NSString *)message autoHide:(BOOL)autoHide;

- (void)hide;

@end
