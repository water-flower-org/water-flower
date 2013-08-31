//
//  TableDataSource.m
//  water-flower
//
//  Created by ss on 8/25/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "TableDataSource.h"

@implementation TableDataSource

- (id) init {
    self = [super init];
    if ( self ) {
        m_data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) getAll {
    return m_data;
}

- (TableData *) getDataAtIndex:(int)index {
    return [m_data objectAtIndex:index];
}

- (TableData *) createDataWith:(int)data {
    TableData * t = [[TableData alloc] initWithData:data];
    [m_data addObject:t];
    return t;
}

- (void)sort {
    [m_data sortUsingSelector:@selector(compare:)];
}

- (void)sortDataOnly {
    [m_data sortUsingSelector:@selector(compareDataOnly:)];
}

- (void)removeDataAtIndex:(int)index {
    NSLog(@"remove at %d", index);
    TableData * t = [self getDataAtIndex:index];
    [m_data removeObject:t];
}

- (NSArray *) getAllCategories {
    // what we can get are just 0 and 1
    return [[NSArray alloc] initWithObjects:0, 1, nil];
}

- (NSArray *) getAllItemsForCategory:(int)category {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for ( int i = 0; i < [m_data count]; ++i ) {
        TableData * t = [m_data objectAtIndex:i];
        if ( t.category == category ) {
            [ret addObject:t];
        }
    }
    return ret;
}

- (NSArray *) proposeItemsToAddForCategory:(int)category withCount:(int)count {
    
    NSMutableArray * ret = [[NSMutableArray alloc]init];
    NSArray * t = [self getAllItemsForCategory:category];
    TableData * maxData = [t lastObject];
    
    int maxInd = (maxData) ? maxData.data : 0;
    
    for ( int i = 0; i < count; ++i ) {
        TableData * n = [[TableData alloc] initWithData:(maxInd + i + 1)];
        [ret addObject:n];
    }
    
    return ret;
    
}

+ (TableDataSource *) getInstance {
    static TableDataSource * inst = nil;
    if ( !inst ) {
        inst = [[super allocWithZone:nil] init];
    }
    return inst;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self getInstance];
}

@end
