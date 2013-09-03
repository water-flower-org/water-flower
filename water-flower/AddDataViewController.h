//
//  AddDataViewController.h
//  water-flower
//
//  Created by ss on 9/4/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDataDelegate.h"
#import "AddDataDelegate.h"
#import "ReloadDataDelegate.h"

@interface AddDataViewController : UIViewController

@property (weak, nonatomic) id <GetDataDelegate, AddDataDelegate> dataDelegate;
@property (weak, nonatomic) id <ReloadDataDelegate> reloadDelegate;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)addClicked:(id)sender;

@end
