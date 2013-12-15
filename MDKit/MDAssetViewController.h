//
//  MDAssetViewController.h
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface MDAssetViewController : UIViewController

@property (strong, nonatomic) void (^assetCallback)(ALAsset *asset);
@property (strong, nonatomic) ALAsset *asset;
@property (weak) IBOutlet UIImageView *imageView;


- (void)confirmAsset;

@end
