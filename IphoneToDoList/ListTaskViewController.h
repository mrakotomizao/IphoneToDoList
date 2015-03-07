//
//  ListTaskViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 23/02/2015.
//  Copyright (c) 2015 Moïse Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "backgroundLayer.h"

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

