//
//  TableDataSource.h
//  water-flower
//
//  Created by ss on 8/25/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableData.h"

@interface TableDataSource : NSObject {
}

@property NSString * saveFilePath;
@property NSMutableArray * m_data;

- (NSArray *) getAll;
- (TableData *) createDataWith:(int)data;
- (TableData *) getDataAtIndex:(int)index;
- (void)sort;
- (void)sortDataOnly;
- (void)removeDataAtIndex:(int)index;
- (NSArray *) getAllCategories;
- (NSArray *) getAllItemsForCategory:(int)category;
- (NSArray *) proposeItemsToAddForCategory:(int)category withCount:(int)count;
- (BOOL)save;

+ (TableDataSource *) getInstance;

@end
