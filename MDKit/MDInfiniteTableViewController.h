//
//  MDInfiniteTableViewController.h
//  MDKit
//
//  Created by Matthew Dicembrino on 9/2/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDLoadingCell.h"

static NSString *MDLoadingCellIdentifier = @"MDLoadingCell";

@protocol MDInfiniteTableViewControllerDelegate;

@interface MDInfiniteTableViewController : UITableViewController {
 
@private
    CGFloat _lastOffset;

}

//Base delegate, sublcasses should create their own, and implement this protocol.
//Make sure to use @dynamic delegate in implementation.
@property (nonatomic, weak) id <MDInfiniteTableViewControllerDelegate> delegate;

//BOOL that determines if the user has scrolled to the last page or not
@property (nonatomic, getter = isPaging) BOOL paging;

//The current page number the user has scrolled to.
@property (nonatomic) NSInteger page;

//The indexPath that the user has selected by pressing a button or a gesture recongizer.
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

//The mutable table data for the tableview.
@property (strong, nonatomic) NSMutableArray *tableData;

//TableViewCell used to display a loading spinner
@property (strong, nonatomic) MDLoadingCell *loadingCell;

//Called to load new data
- (void)createTableData:(NSArray *)tableData;

//Called when finishing creating Table Data and checks whether this is the start of content or an append.

- (void)addDataToTableView:(NSArray *)tableData;

//Called when the system pull to refresh is pulled, this method should fire the corresponding delegate method "didPullToRefresh:"
- (void)didPullToRefresh:(id)sender;

//Called when wanting to manually refresh the page from a notification or other event.
- (void)refreshTableView;

//Called when parent controller is finished loading more data after a refresh.
- (void)hideRefresh;

//Called in viewDidLoad to register custom UITableViewCell subclasses nib files.
- (void)registerNibs;

//Called when needing to reset the tableview to default state.
- (void)reset;

//Return a loading cell at supplied indexPath.
- (MDLoadingCell *)loadingCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)checkForData:(NSArray *)tableData;

@end

//Base Protocol
@protocol MDInfiniteTableViewControllerDelegate <NSObject>

//Called when the refresh control finishes a pull.
- (void)didPullToRefresh:(MDInfiniteTableViewController *)aController;

//Called when the tableview reaches the end of its data and self.paging = YES
- (void)tableController:(MDInfiniteTableViewController *)aController shouldPaginate:(NSInteger)page;

@optional

- (void)didFinishLoading:(MDInfiniteTableViewController *)aController;

- (void)tableController:(MDInfiniteTableViewController *)aController didTapOnMention:(NSString *)mention;

/*
 Notify the delegate that the tableview is scrolling downward.
 */
- (void)tableControllerDidScrollDown:(MDInfiniteTableViewController *)aController;

/*
 Notify the delegate that the tableview is scrolling upward.
 */
- (void)tableControllerDidScrollUp:(MDInfiniteTableViewController *)aController;

- (void)tableController:(MDInfiniteTableViewController *)aController didChangeContentOffset:(CGPoint)offset;

- (NSString *)tableViewTitleForHeader:(MDInfiniteTableViewController *)tableView;



@end