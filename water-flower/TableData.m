//
//  TableData.m
//  water-flower
//
//  Created by ss on 8/25/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "TableData.h"

@interface TableData ()

@property (readwrite) NSString *descFormat;

@end

@implementation TableData

- (id) initWithData:(int)data {
    self.descFormat = @"category: %d, index: %d";
    self = [super init];
    if ( self ) {
        self.data = data;
        self.category = self.data % 2;
    }
    return self;
}

- (NSComparisonResult)compare:(TableData*)other {
    if (self.category < other.category) {
        return NSOrderedAscending;
    }
    
    if (self.category > other.category) {
        return NSOrderedDescending;
    }
    
    return [self compareDataOnly:other];
}

- (NSComparisonResult)compareDataOnly:(TableData*)other {
    if (self.data == other.data) {
        return NSOrderedSame;
    } else if (self.data < other.data) {
        return NSOrderedAscending;
    } else return NSOrderedDescending;
}

- (void)update:(int)data {
    self.data = data;
    self.category = self.data % 2;
}

- (NSString *)getDesc {
    return [NSString stringWithFormat:self.descFormat, self.category, self.data];
}

@end
