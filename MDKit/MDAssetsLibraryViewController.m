//
//  MDAssetsLibraryHomeViewController.m
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDAssetsLibraryViewController.h"
#import "MDAssetsManager.h"

@interface MDAssetsLibraryViewController ()

@end

@implementation MDAssetsLibraryViewController

#pragma mark - IBAction

- (IBAction)unwindtoAssetsLibrary:(UIStoryboardSegue *)segue {
    
}

- (MDLibraryCollectionViewCell *)libraryCellAtIndexPath:(NSIndexPath *)indexPath {
    MDLibraryCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"LibraryCell" forIndexPath:indexPath];
    ALAsset *asset = [_assets objectAtIndex:indexPath.row - 1];
    CGImageRef posterImageRef = asset.thumbnail;
    cell.imageView.image = [UIImage imageWithCGImage:posterImageRef];
    return cell;
}

- (void)reloadAssetGroup {
    [self _getAssetsForGroup:_selectedGroup];
}

- (void)showAnimated:(BOOL)animated {
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.alpha = 1.0;
                     }];
}

- (void)libraryDidChangeNotification {
    [self reloadAssetGroup];
}

- (BOOL)isCameraRollGroup:(ALAssetsGroup *)group {
    return [[group valueForProperty:ALAssetsGroupPropertyType] isEqualToNumber:[NSNumber numberWithInt:ALAssetsGroupSavedPhotos]];
}

- (ALAsset *)assetAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCameraRollGroup:self.selectedGroup]) {
        return self.assets[indexPath.row - 1];
    } else {
        return self.assets[indexPath.row];
    }
}

#pragma mark - Private

- (void)_getAssetGroups {
    self.groups = [NSMutableArray array];
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            if ([self isCameraRollGroup:group]) {
                [self _getAssetsForGroup:group];
            }
            [_groups addObject:group];
        } 
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
      //  NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                //errorMessage = @"The user has declined access to it.";
                self.noAccessLabel.alpha = 1.0;
                self.collectionView.alpha = 0.0;
                self.accessDenied = YES;
                [self showAnimated:YES];
                break;
            default:
                break;
        }
        //Show no access
        
    };
    
    NSUInteger groupTypes = ALAssetsGroupAll;
    [[[MDAssetsManager sharedInstance] defaultAssetsLibrary] enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
}

- (void)_getAssetsForGroup:(ALAssetsGroup *)group {
    self.selectedGroup = group;
    if (!_assets) {
        self.assets = [[NSMutableArray alloc] init];
    } else {
        [_assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            [_assets addObject:result];
        } else {
            self.assets = [[[_assets reverseObjectEnumerator] allObjects] mutableCopy];
            [_collectionView reloadData];
            [self showAnimated:YES];
        }
    };
    
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [group setAssetsFilter:onlyPhotosFilter];
    [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MDLibraryCollectionViewCell *cell = sender;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    if (indexPath.row > 0) {
        //MDPhotoViewController *controller = segue.destinationViewController;
        //controller.asset = _assets[indexPath.row - 1];
    }
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self isCameraRollGroup:self.selectedGroup]) {
        return _assets.count + 1;
    }
    return _assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && [self isCameraRollGroup:self.selectedGroup]) {
        MDLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        return cell;
    } else {
        return [self libraryCellAtIndexPath:indexPath];
    }
    
}

#pragma makr - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0.0;
    self.noAccessLabel.alpha = 0.0;
    if (self.selectedGroup) {
        [self _getAssetsForGroup:self.selectedGroup];
    } else {
        [self _getAssetGroups];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(libraryDidChangeNotification) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.accessDenied) {
        [self _getAssetGroups];
    }
}

- (void)dealloc {
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
