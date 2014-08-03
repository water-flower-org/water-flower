//
//  AddDataViewController.m
//  water-flower
//
//  Created by ss on 9/4/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "AddDataViewController.h"

@interface AddDataViewController ()

@end

@implementation AddDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSInteger d = [self.dataDelegate getDataForCurrentIndex];
    self.textLabel.text = [NSString stringWithFormat:@"%ld", d];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClicked:(id)sender {
    [self.dataDelegate addData:self.textLabel.text.intValue];
    [self.reloadDelegate reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
