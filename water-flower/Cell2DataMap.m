//
//  Cell2DataMap.m
//  water-flower
//
//  Created by ss on 9/2/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "Cell2DataMap.h"

@implementation Cell2DataMap

- (id)initWithCategories:(NSArray *)categories {
    self = [super init];
    if ( self ) {
        self.cell2category = [[NSMutableDictionary alloc]init];
        self.cell2data = [[NSMutableDictionary alloc]init];
        for ( int i = 0; i < categories.count; ++i ) {
            NSNumber * key = [categories objectAtIndex:i];
            NSIndexPath * val = [NSIndexPath indexPathForRow:i inSection:0];
            [self.cell2category setObject:val forKey:key];
        }
    }
    return self;
}

- (BOOL)indexPathIsMaster:(NSIndexPath *)indexPath {
    for ( id key in self.cell2category ) {
        NSIndexPath * p = [self.cell2category objectForKey:key];
        if ( [p isEqual:indexPath] ) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)indexPathIsDetail:(NSIndexPath *)indexPath {
    for ( id key in self.cell2data ) {
        NSIndexPath * t = [self.cell2data objectForKey:key];
        if ( [t isEqual:indexPath] ) {
            return YES;
        }
    }
    return NO;
}

- (void)dumpAll {
    NSLog(@"category:");
    for ( NSNumber * n in self.cell2category ) {
        NSIndexPath * p = [self.cell2category objectForKey:n];
        NSLog(@"category %d: %d", n.intValue, p.row);
    }
    NSLog(@"data:");
    for ( TableData * t in self.cell2data ) {
        NSIndexPath * p = [self.cell2data objectForKey:t];
        NSLog(@"category %d data %d: %d", t.category, t.data, p.row);
    }
}

- (void)setFor:(NSMutableDictionary *)dict After:(NSIndexPath *)indexPath withVal:(int)val {
    int di = indexPath.row;
    for ( id t in [dict allKeys] ) {
        NSIndexPath * tp = [dict objectForKey:t];
        int ti = tp.row;
        if ( ti > di ) {
            NSIndexPath * tv = [NSIndexPath indexPathForRow:(ti + (val)) inSection:0];
            [dict setObject:tv forKey:t];
        }
    }
}

- (void)setAllAfter:(NSIndexPath *)indexPath withVal:(int)val {
    [self setFor:self.cell2category After:indexPath withVal:val];
    [self setFor:self.cell2data After:indexPath withVal:val];
}

- (void)addData:(TableData *)data forCategory:(int)category afterIndex:(NSIndexPath*)indexPath {
    
    NSIndexPath * currentPath = [self.cell2data objectForKey:data];
    if ( currentPath ) {
        return;
    }
    
    [self setAllAfter:indexPath withVal:(+1)];
    
    NSIndexPath * newPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0];
    [self.cell2data setObject:newPath forKey:data];

}

- (void)rmData:(TableData*)data forCategory:(int)category atIndex:(NSIndexPath*)currentRow {
    NSIndexPath * currentPath = [self.cell2data objectForKey:data];
    if ( currentPath ) {
        [self.cell2data removeObjectForKey:data];
    }
    
    [self setAllAfter:currentRow withVal:(-1)];
}

- (TableData*)dataAtIndexPath:(NSIndexPath*)indexPath {
    for ( TableData * key in self.cell2data ) {
        NSIndexPath * p = [self.cell2data objectForKey:key];
        if ( [p isEqual:indexPath] ) {
            return key;
        }
    }
    return nil;
}

- (int)categoryAtIndexPath:(NSIndexPath*)indexPath {
    for ( NSNumber * key in self.cell2category ) {
        NSIndexPath * p = [self.cell2category objectForKey:key];
        if ( [p isEqual:indexPath] ) {
            return key.intValue;
        }
    }
    return -1;
}

- (int)indexForCategory:(int)c {
    NSNumber * k = [NSNumber numberWithInt:c];
    NSIndexPath * p = [self.cell2category objectForKey:k];
    if ( p ) {
        return p.row;
    } else {
        return -1;
    }
}

- (int)indexForData:(TableData*)data {
    NSIndexPath * p = [self.cell2data objectForKey:data];
    if ( p ) {
        return p.row;
    } else {
        return -1;
    }
}

- (int)totalRows {
    int dataRows = [self.cell2data allKeys].count;
    int cateRows =[self.cell2category allKeys].count;
    return dataRows + cateRows;
}

@end
