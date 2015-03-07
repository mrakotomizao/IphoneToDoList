//
//  ProjectViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 bullsgates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "ListTaskViewController.h"
#import "backgroundLayer.h"
#import "CustomCell.h"


@interface ListProjectViewController : UITableViewController
{
    AppDelegate *app;
    NSManagedObjectContext *context;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic)NSArray *menuItems;


@end
