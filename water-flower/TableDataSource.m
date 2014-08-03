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
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.saveFilePath = @"store.plist";
        NSData *data = [userDefaults objectForKey:self.saveFilePath];
        self.m_data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ( !self.m_data ) {
            NSLog(@"creating new data");
            self.m_data = [[NSMutableArray alloc] init];
        } else {
            NSLog(@"loaded data");
            [self sortDataOnly];
        }
        /*NSFileManager *fileManager = [NSFileManager defaultManager];
        if ( [fileManager fileExistsAtPath:self.saveFilePath] ) {
            NSLog(@"reading from file");
            self.m_data = [[NSMutableArray alloc] initWithContentsOfFile:self.saveFilePath];
            [self sortDataOnly];
        } else {
            NSLog(@"creating new data");
            self.m_data = [[NSMutableArray alloc] init];
        }*/
    }
    return self;
}

- (NSArray *) getAll {
    return self.m_data;
}

- (TableData *) getDataAtIndex:(NSInteger)index {
    return [self.m_data objectAtIndex:index];
}

- (TableData *) createDataWith:(NSInteger)data {
    TableData * t = [[TableData alloc] initWithData:data];
    [self.m_data addObject:t];
    return t;
}

- (void)sort {
    [self.m_data sortUsingSelector:@selector(compare:)];
}

- (void)sortDataOnly {
    [self.m_data sortUsingSelector:@selector(compareDataOnly:)];
}

- (void)removeDataAtIndex:(NSInteger)index {
    TableData * t = [self getDataAtIndex:index];
    [self.m_data removeObject:t];
}

- (NSArray *) getAllCategories {
    // what we can get are just 0 and 1
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    [ret addObject:[NSNumber numberWithInt:0]];
    [ret addObject:[NSNumber numberWithInt:1]];
    return ret;
}

- (NSArray *) getAllItemsForCategory:(NSInteger)category {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for ( int i = 0; i < [self.m_data count]; ++i ) {
        TableData * t = [self.m_data objectAtIndex:i];
        if ( t.category == category ) {
            [ret addObject:t];
        }
    }
    return ret;
}

- (NSArray *) proposeItemsToAddForCategory:(NSInteger)category withCount:(NSInteger)count {
    
    NSMutableArray * ret = [[NSMutableArray alloc]init];
    NSArray * t = [self getAllItemsForCategory:category];
    TableData * maxData = [t lastObject];
    
    NSInteger maxInd = (maxData)? maxData.data : (category - 2);
    for ( int i = 0; i < count; ++i ) {
        TableData * n = [[TableData alloc] initWithData:(maxInd + (i + 1) * 2)];
        [ret addObject:n];
    }
    
    return ret;
    
}

- (BOOL) save {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.m_data];
    [userDefaults setObject:data forKey:self.saveFilePath];
    return YES;
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
