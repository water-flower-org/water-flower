//
//  Cell2DataMap.h
//  water-flower
//
//  Created by ss on 9/2/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableData.h"

@interface Cell2DataMap : NSObject

- (id)initWithCategories:(NSArray*)categories;
- (BOOL)indexPathIsMaster:(NSIndexPath *)indexPath;
- (BOOL)indexPathIsDetail:(NSIndexPath *)indexPath;
- (void)addData:(TableData *)data forCategory:(int)category afterIndex:(NSIndexPath*)indexPath;
- (void)rmData:(TableData*)data forCategory:(int)category atIndex:(NSIndexPath*)currentPath;
- (TableData*)dataAtIndexPath:(NSIndexPath*)indexPath;
- (int)categoryAtIndexPath:(NSIndexPath*)indexPath;
- (int)indexForCategory:(int)c;
- (int)indexForData:(TableData*)data;
- (int)totalRows;

// {(NSNumber*)category, (NSIndexPath*)path}
@property NSMutableDictionary* cell2category;
// {(TableData*)data, (NSIndexPath*)path}
@property NSMutableDictionary* cell2data;

@end
