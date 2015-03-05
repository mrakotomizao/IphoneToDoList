//
//  ProjectViewController.h
//  ToDoList
//
//  Created by Seheno Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
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
