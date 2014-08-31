//
//  NSIndexPath+Touch.h
//   MDKit
//
//  Created by Matthew Dicembrino on 10/17/12.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Touch)

+ (NSIndexPath *)indexPathForTouch:(id)sender event:(id)event tableView:(UITableView *)tableView;
+ (NSIndexPath *)indexPathForTouch:(id)sender event:(id)event collectionView:(UICollectionView *)collectionView;

@end
