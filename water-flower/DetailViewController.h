//
//  DetailViewController.h
//  water-flower
//
//  Created by ss on 8/27/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateDataDelegate.h"
#import "GetDataDelegate.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) id <UpdateDataDelegate, GetDataDelegate> dataDelegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property BOOL isRemoving;

- (IBAction)delClicked:(id)sender;

@end
