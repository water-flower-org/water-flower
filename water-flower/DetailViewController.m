//
//  DetailViewController.m
//  water-flower
//
//  Created by ss on 8/27/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)bgViewClicked:(id)sender;

@end

@implementation DetailViewController

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
    int d = [self.dataDelegate getDataForCurrentIndex];
    self.textField.text = [NSString stringWithFormat:@"%d", d];
    self.isRemoving = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    if ( !self.isRemoving ) { 
        [self.dataDelegate setDataForCurrentIndex: self.textField.text.intValue];
    }
}

- (IBAction)bgViewClicked:(id)sender {
    [self.textField resignFirstResponder];
}

- (IBAction)delClicked:(id)sender {
    self.isRemoving = YES;
    [self.dataDelegate delDataForCurrentIndex];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
