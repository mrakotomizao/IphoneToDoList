//
//  TaskViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TaskViewController : UITableViewController
{
    AppDelegate *app;
    NSManagedObjectContext *context;
    NSArray *mesResultat;
}

@property (weak, nonatomic) IBOutlet UIPickerView *listProject;
@property (nonatomic) NSArray * unProjet;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIDatePicker *duedate;

@end
