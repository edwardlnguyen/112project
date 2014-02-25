//
//  InventoryViewController.m
//  hard112project
//
//  Created by Edward Nguyen on 2/25/14.
//  Copyright (c) 2014 Edward Nguyen. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController
@synthesize myTableView, items;

//newly added
- (NSMutableArray *) items {
    if (!items)
        items = [[NSMutableArray alloc] init];
        return items;
    }

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items = [[NSMutableArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", nil];
    
    //add an "insert" button such that it is placed onto the bar, with insert action
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(insertNewObject)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}

//new function insertNewObject
- (void)insertNewObject
{
    //use UIAlertView to instantiate the alert when it pops up
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Enter Food and Expiration Date" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    
    //style of alert message
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //show the alert on the user's screen
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//edit the tables
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [myTableView setEditing:editing animated:animated];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // if the user hits done
    if (buttonIndex == 1) {
        // save into a string a temporary text field from the alertview from the first slot of 0 (location)
        NSString *tempText = [alertView textFieldAtIndex:0].text;
        
        if(!items){
            items = [[NSMutableArray alloc] init];
            
        }
        
        //insert the value at the top, because it is one in, then shift down. if you insert at the back, segmentation fault
        [items insertObject:tempText atIndex:0];
        
        //add it to our table view by changing the indexPath to 0, then using that path to insert the new item
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.myTableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    return cell;
}

// following 2 functions implement deletion table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //first, remove from NSmutableArray from index of indexpath
        [items removeObjectAtIndex:indexPath.row];
        //then update the tableView by removing it from tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}


@end
