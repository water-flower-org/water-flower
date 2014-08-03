//
//  UpdateDataDelegate.h
//  water-flower
//
//  Created by ss on 8/27/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

@protocol UpdateDataDelegate

- (void)setDataForCurrentIndex:(NSInteger)data;
- (void)delDataForCurrentIndex;

@end
