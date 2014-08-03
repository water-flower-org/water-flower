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
- (TableData *) createDataWith:(NSInteger)data;
- (TableData *) getDataAtIndex:(NSInteger)index;
- (void)sort;
- (void)sortDataOnly;
- (void)removeDataAtIndex:(NSInteger)index;
- (NSArray *) getAllCategories;
- (NSArray *) getAllItemsForCategory:(NSInteger)category;
- (NSArray *) proposeItemsToAddForCategory:(NSInteger)category withCount:(NSInteger)count;
- (BOOL)save;

+ (TableDataSource *) getInstance;

@end
