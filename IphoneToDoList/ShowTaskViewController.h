//
//  ShowTaskViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 24/02/2015.
//  Copyright (c) 2015 Moïse Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "backgroundLayer.h"
@interface ShowTaskViewController : UITableViewController
{
    AppDelegate *app;
    NSManagedObjectContext *context;
}

@property (nonatomic)NSArray *menuItems;
@property (nonatomic) NSArray * uneTache;
@property (nonatomic) NSArray * unProjet;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *dueDate;
@property (weak, nonatomic) IBOutlet UITextField *purcent;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic) NSArray * progression;
@end
