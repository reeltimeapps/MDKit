//
//  MDAssetsLibraryHomeViewController.h
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MDLibraryCollectionViewCell.h"
#import "MDAssetViewController.h"
#import "MDLibrarySegue.h"
#import "MDCameraSegue.h"


@interface MDAssetsLibraryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

}

@property (nonatomic) BOOL accessDenied;

@property (nonatomic, strong) void (^assetCallback)(ALAsset *asset);
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) ALAsset *selectedAsset;
@property (strong, nonatomic) NSMutableArray *groups;
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) ALAssetsGroup *selectedGroup;

@property (weak, nonatomic) IBOutlet UILabel *noAccessLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)unwindtoAssetsLibrary:(UIStoryboardSegue *)segue;
- (MDLibraryCollectionViewCell *)libraryCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadAssetGroup;
- (void)libraryDidChangeNotification;
- (BOOL)isCameraRollGroup:(ALAssetsGroup *)group;
- (ALAsset *)assetAtIndexPath:(NSIndexPath *)indexPath;
@end
