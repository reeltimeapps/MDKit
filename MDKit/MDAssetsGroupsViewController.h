//
//  MDAssetsGroupsViewController.h
//   MDKit
//
//  Created by Matthew Dicembrino on 12/12/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MDAssetsManager.h"

@interface MDAssetsGroupsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL accessDenied;
@property (strong, nonatomic) ALAssetsGroup *selectedGroup;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (weak, nonatomic) IBOutlet UILabel *noAccessLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)getAssetGroups;
- (void)showAnimated:(BOOL)animated;
- (void)registerCell;

@end
