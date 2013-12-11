//
//  MDInfiniteTableViewController.m
//  MDKit
//
//  Created by Matthew Dicembrino on 9/2/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import "MDInfiniteTableViewController.h"
#import "NSBundle+MDKit.h"

@interface MDInfiniteTableViewController ()

@property BOOL isDragging;

@end

@implementation MDInfiniteTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.backgroundView = nil;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - Public

- (void)refreshTableView {
    self.page = 1;
    [self hideRefresh];
}

- (void)didPullToRefresh:(id)sender {
    self.tableData = nil;
    self.page = 1;
    [self.delegate didPullToRefresh:self];
}

- (void)hideRefresh {
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (void)reset {
    [self.tableData removeAllObjects];
    self.tableData = nil;
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:MDLoadingCellIdentifier bundle:[NSBundle mdkitResources]] forCellReuseIdentifier:MDLoadingCellIdentifier];
}

- (void)createTableData:(NSArray *)tableData {
    if (self.page == 1) {
        [self reset];
    }
    [self checkForData:tableData];
}

- (void)checkForData:(NSArray *)tableData {
    [self hideRefresh];
    if ([tableData count] == 0) {
        self.paging = NO;
        [self.loadingCell.activityIndicator stopAnimating];
        return;
    }
    self.paging = YES;
}

- (void)addDataToTableView:(NSArray *)tableData {
    if (self.tableData == nil) {
        self.tableData = [tableData mutableCopy];
        [self.tableView reloadData];
    } else {
        NSArray *indexPaths =[self indexPathsToReload:self.tableData.count count:tableData.count];
        [self.tableData addObjectsFromArray:tableData];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (MDLoadingCell *)loadingCellAtIndexPath:(NSIndexPath *)indexPath {
    self.loadingCell = [self.tableView dequeueReusableCellWithIdentifier:MDLoadingCellIdentifier forIndexPath:indexPath];
    if ([self isPaging]) {
        [_loadingCell.activityIndicator startAnimating];
    }
    return _loadingCell;
}

#pragma mark - Private

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(didPullToRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)addInsetToTableView {
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = 44;
    self.tableView.contentInset = insets;
}

- (NSArray *)indexPathsToReload:(NSInteger)startRow count:(NSInteger)count {
    if (!startRow) {
        startRow = 0;
    }
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startRow + i inSection:0];
        [temp addObject:indexPath];
    }
    return temp;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(tableController:didChangeContentOffset:)]) {
        [self.delegate tableController:self didChangeContentOffset:scrollView.contentOffset];
    }
    if (scrollView.contentOffset.y > 0) {
        if (scrollView.contentOffset.y > _lastOffset && _isDragging) {
            if ([self.delegate respondsToSelector:@selector(tableControllerDidScrollDown:)]) {
                [self.delegate tableControllerDidScrollDown:self];
            }
        }
        else if (scrollView.contentOffset.y < _lastOffset && _isDragging) {
            if ([self.delegate respondsToSelector:@selector(tableControllerDidScrollUp:)]) {
                [self.delegate tableControllerDidScrollUp:self];
            }
        }
    }
    _lastOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isDragging = NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(tableControllerDidScrollUp:)]) {
        [self.delegate tableControllerDidScrollUp:self];
    }
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.tableData.count;
    }
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == [self.tableData count] - 1 && self.paging) {
        self.page++;
        if ([self.delegate respondsToSelector:@selector(tableController:shouldPaginate:)]) {
            [self.delegate tableController:self shouldPaginate:self.page];
        }
    }
}

#pragma mark - View Lifecylce

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshControl];
    [self addInsetToTableView];
    [self registerNibs];
    self.page = 1;
    self.paging = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
