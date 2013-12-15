//
//  MDAssetViewController.m
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDAssetViewController.h"
#import "UIImage+WBImage.h"
#import "ALAsset+UIImage.h"

@interface MDAssetViewController ()

@end

@implementation MDAssetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)confirmAsset {
    self.assetCallback(self.asset);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self _setImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)_setImage {
    
   
    self.imageView.image = [_asset originalImage];
}

@end
