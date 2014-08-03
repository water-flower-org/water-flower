//
//  TableData.h
//  water-flower
//
//  Created by ss on 8/25/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableData : NSObject <NSCopying> {

}

@property NSInteger category;
@property NSInteger data;
@property (readonly) NSString *descFormat;

- (NSString *)getDesc;
- (id)initWithData:(NSInteger)data;
- (void)update:(NSInteger)data;
- (NSComparisonResult)compare:(TableData*)other;
- (NSComparisonResult)compareDataOnly:(TableData*)other;

@end
