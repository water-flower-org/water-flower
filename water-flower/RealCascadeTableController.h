//
//  RealCascadeTableController.h
//  water-flower
//
//  Created by ss on 8/29/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableDataSource.h"
#import "Cell2DataMap.h"
#import "GetDataDelegate.h"
#import "AddDataDelegate.h"
#import "ReloadDataDelegate.h"

@interface RealCascadeTableController : UITableViewController <GetDataDelegate, AddDataDelegate>

@property (weak, nonatomic) TableDataSource *ds;
@property Cell2DataMap * cell2data;
@property (weak, nonatomic) id <ReloadDataDelegate> reloadDelegate;

@end
