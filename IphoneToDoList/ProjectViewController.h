//
//  ProjectViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 bullsgates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProjectViewController : UITableViewController{
    AppDelegate *app;
    NSManagedObjectContext *context;
    NSArray *mesResultat;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@end
