//
//  ShoppingListViewController.h
//  hard112project
//
//  Created by Edward Nguyen on 2/25/14.
//  Copyright (c) 2014 Edward Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *items;
@end
