//
//  ProjectViewController.h
//  ToDoList
//
//  Created by Seheno Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "ListTaskViewController.h"

@interface ListProjectViewController : UIViewController
{
    AppDelegate *app;
    NSManagedObjectContext *context;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic)NSArray *menuItems;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end
