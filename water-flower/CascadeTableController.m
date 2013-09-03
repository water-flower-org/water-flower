//
//  CascadeTableController.m
//  water-flower
//
//  Created by ss on 8/25/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "CascadeTableController.h"
#import "DetailViewController.h"
#import "RealCascadeTableController.h"

@interface CascadeTableController ()

@end

@implementation CascadeTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// walkaround as initwithstyle not called
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        self.ds = [TableDataSource getInstance];
        for ( int i = 0; i < 5; ++i ) {
            [self.ds createDataWith:i];
        }
        [self.ds sortDataOnly];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"一个牛逼列表";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueMaster2Detail"]) {
        DetailViewController *c = segue.destinationViewController;
        c.dataDelegate = self;
        return;
    }
    if ([segue.identifier isEqualToString:@"SegueAdd"]) {
        RealCascadeTableController *c = segue.destinationViewController;
        c.reloadDelegate = self;
        return;
    }
}

- (int)getDataForCurrentIndex {
    int row = [self.tableView indexPathForSelectedRow].row;
    TableData * t = [self.ds getDataAtIndex:row];
    return t.data;
}

- (void)setDataForCurrentIndex:(int)data {
    int row = [self.tableView indexPathForSelectedRow].row;
    TableData * t = [self.ds getDataAtIndex:row];
    [t update:data];
    [self.ds sortDataOnly];
    [self.tableView reloadData];
}

- (void)delDataForCurrentIndex {
    int row = [self.tableView indexPathForSelectedRow].row;
    [self.ds removeDataAtIndex:row];
    [self.ds sortDataOnly];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.ds getAll] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LoaderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TableData * t = [self.ds getDataAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"item at index: %d", t.data];
    cell.detailTextLabel.text = [t getDesc];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

}

@end
