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

- (void)update:(int)data {
    self.data = data;
    self.category = self.data % 2;
}

- (NSString *)getDesc {
    return [NSString stringWithFormat:self.descFormat, self.category, self.data];
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

- (NSUInteger)hash;
{
    NSString *k = [NSString stringWithFormat:@"%@_%d_%d", @"TableData", self.category, self.data];
    return [k hash];
}

- (BOOL)isEqual:(id)other;
{
    if ( [other isKindOfClass:[TableData class]] ) {
        TableData * o = (TableData*)other;
        return (self.data == o.data) && (self.category == o.category);
    } else {
        return NO;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    TableData *objectCopy = [[TableData allocWithZone:zone] init];
    // Copy over all instance variables from self to objectCopy.
    // Use deep copies for all strong pointers, shallow copies for weak.
    objectCopy.data = self.data;
    objectCopy.category = self.category;
    return objectCopy;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithInt:self.data] forKey:@"data"];
    [encoder encodeObject:[NSNumber numberWithInt:self.category] forKey:@"category"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        NSNumber* t = [decoder decodeObjectForKey:@"data"];
        self.data = t.integerValue;
        t = [decoder decodeObjectForKey:@"category"];
        self.category = t.integerValue;
        self.descFormat = @"category: %d, index: %d";
    }
    return self;
}

@end
