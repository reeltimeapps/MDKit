//
//  MDAssetsGroupsViewController.m
//  Slide
//
//  Created by Matthew Dicembrino on 12/12/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import "MDAssetsGroupsViewController.h"
#import "MDAssetsGroupTableViewCell.h"

static NSString *MDAssetsGroupTableViewCellIdentifier = @"MDAssetsGroupTableViewCell";

@interface MDAssetsGroupsViewController ()

@end

@implementation MDAssetsGroupsViewController

#pragma mark - Public

- (void)getAssetGroups {
    self.tableData = [NSMutableArray array];
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [_tableData addObject:group];
        } else {
            [_tableView reloadData];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        //  NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                //errorMessage = @"The user has declined access to it.";
                self.noAccessLabel.alpha = 1.0;
                self.tableView.alpha = 0.0;
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

- (void)showAnimated:(BOOL)animated {
    [UIView animateWithDuration:0.25
                     animations:^{
                         _tableView.alpha = 1.0;
                     }];
}

- (void)registerCell {
    [self.tableView registerClass:[MDAssetsGroupTableViewCell class] forCellReuseIdentifier:MDAssetsGroupTableViewCellIdentifier];
}

#pragma mark - View Lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self getAssetGroups];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDAssetsGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MDAssetsGroupTableViewCellIdentifier forIndexPath:indexPath];
    ALAssetsGroup *group = _tableData[indexPath.row];
    
    cell.coverImageView.image = [UIImage imageWithCGImage:group.posterImage];
    cell.titleLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%i photos", group.numberOfAssets];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

@end
