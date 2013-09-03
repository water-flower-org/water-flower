//
//  RealCascadeTableController.m
//  water-flower
//
//  Created by ss on 8/29/13.
//  Copyright (c) 2013 ss. All rights reserved.
//

#import "RealCascadeTableController.h"
#import "AddDataViewController.h"

@interface RealCascadeTableController ()

@end

@implementation RealCascadeTableController

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
        self.cell2data = [[Cell2DataMap alloc]initWithCategories: [self.ds getAllCategories]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选择一个category";

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

- (int)getDataForCurrentIndex {
    int row = [self.tableView indexPathForSelectedRow].row;
    TableData * t = [self.cell2data dataAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    return t.data;
}

- (void)addData:(int)data {
    [self.ds createDataWith:data];
    [self.ds sortDataOnly];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = [self.cell2data totalRows];
    NSLog(@"numberOfRows: %d", ret);
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"asking for cell at %d", indexPath.row);
    
    if ( [self.cell2data indexPathIsMaster:indexPath] ) { 
        NSString *CellIdentifier = @"CategoryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"category %d", indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"category %d", indexPath.row];
        
        NSLog(@"return master for %d", indexPath.row);
        return cell;
    }
    
    if ( [self.cell2data indexPathIsDetail:indexPath] ) {
        NSString *CellIdentifier = @"ItemCell";
        TableData * t = [self.cell2data dataAtIndexPath:indexPath];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"item %d", t.data];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"from category %d", t.category];
        
        NSLog(@"return detail for %d", indexPath.row);
        return cell;
    }
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueAdd"]) {
        AddDataViewController *c = segue.destinationViewController;
        c.dataDelegate = self;
        c.reloadDelegate = self.reloadDelegate;
    }
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
    
    NSLog(@"cell at %d selected", indexPath.row);
    
    int category = [self.cell2data categoryAtIndexPath:indexPath];
    if ( category != -1 ) {
        NSArray * items = [self.ds proposeItemsToAddForCategory:category withCount:(5 + category)];
        NSMutableArray * newRows;
        
        for ( int i = 0; i < items.count; ++i ) {
            TableData * t = [items objectAtIndex:i];
            int currentRow = [self.cell2data indexForData:t];
            if ( currentRow != -1 ) {
                NSIndexPath * currentPath = [NSIndexPath indexPathForRow:currentRow inSection:0];
                [self.cell2data rmData:t forCategory:category atIndex:currentPath];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:currentPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                int newRow = indexPath.row + 1 + i;
                NSIndexPath * newPath = [NSIndexPath indexPathForRow:newRow inSection:0];
                if ( !newRows ) {
                    newRows = [[NSMutableArray alloc]init];
                }
                [newRows addObject:newPath];
                
                int internalRow = indexPath.row + i;
                NSIndexPath * internalPath = [NSIndexPath indexPathForRow:internalRow inSection:0];
                [self.cell2data addData:t forCategory:category afterIndex:internalPath];
                
            }
        }
        
        if ( newRows ) { 
            [self.tableView insertRowsAtIndexPaths:newRows withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

@end
