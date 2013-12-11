//
//  NSIndexPath+Touch.m
//  BlackPlanet
//
//  Created by Matthew Dicembrino on 10/17/12.
//  Copyright (c) 2012 Blue Whale. All rights reserved.
//

#import "NSIndexPath+Touch.h"

@implementation NSIndexPath (Touch)

+ (NSIndexPath *)indexPathForTouch:(id)sender event:(id)event tableView:(UITableView *)tableView {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tableView];
    return [tableView indexPathForRowAtPoint:currentTouchPosition];
}

+ (NSIndexPath *)indexPathForTouch:(id)sender event:(id)event collectionView:(UICollectionView *)collectionView {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:collectionView];
    return [collectionView indexPathForItemAtPoint:point];
}


@end
