//
//  ShowTaskViewController.h
//  ToDoList
//
//  Created by Seheno Rakotomizao on 24/02/2015.
//  Copyright (c) 2015 Seheno Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
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
@end
