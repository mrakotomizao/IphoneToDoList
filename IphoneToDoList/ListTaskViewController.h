//
//  ListTaskViewController.h
//  ToDoList
//
//  Created by Seheno Rakotomizao on 23/02/2015.
//  Copyright (c) 2015 Seheno Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ListTaskViewController : UITableViewController
{
    AppDelegate *app;
    NSManagedObjectContext *context;
}


@property (weak, nonatomic) IBOutlet UITableView *taskList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic) NSArray * unProjet;
@property (nonatomic) NSArray * tasks;
@property (nonatomic) NSArray *mesResultat;

@property (nonatomic) NSMutableArray *overdueTasks;
@property (nonatomic) NSMutableArray *mustdoTasksOrange;
@property (nonatomic) NSMutableArray *mustdoTasksGreen;
@property (nonatomic) NSMutableArray *completedTasks;

@end

