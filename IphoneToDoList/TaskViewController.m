//
//  TaskViewController.m
//  ToDoList
//
//  Created by Moïse Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "TaskViewController.h"
#import "ListProjectViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![app managedObjectContext]) {
        app = [[UIApplication sharedApplication] delegate];
        context = [app managedObjectContext];
    }
    NSEntityDescription *entityProject = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:context];
    
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityProject];
    
    NSError *error;
    mesResultat = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error.description);
    }
    if ([mesResultat count]>0) {
        _unProjet = [mesResultat objectAtIndex:0];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Création de taches
 */

- (void)createTask{
        NSEntityDescription *entityTask = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
        
        NSManagedObject *newTask = [[NSManagedObject alloc] initWithEntity:entityTask insertIntoManagedObjectContext:context];
        [newTask setValue:_titleField.text forKey:@"title"];
        [newTask setValue:_duedate.date forKey:@"duedate"];
        [newTask setValue:@0 forKey:@"purcent"];
        
        // Create Relationship
        NSMutableSet *tasks = [_unProjet mutableSetValueForKey:@"tasks"];
        [tasks addObject:newTask];
        
        // Add Task to Project
        // Save Managed Object Context
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    // Get the current date
    NSDate *pickerDate = _duedate.date;
    int daysToAdd = -1;
    NSDate *duedate = [pickerDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = duedate;
    //localNotification.repeatInterval = 60;
    localNotification.alertBody = [NSString stringWithFormat:@"Date limite à : %@",_duedate.date ];
    NSString *titleAlert = [NSString stringWithFormat:@"Task ToDo : %@",_titleField.text ];
    localNotification.alertAction = titleAlert;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    NSLog(@"%@",localNotification.fireDate);
    //NSLog(@"%@",pickerDate);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_titleField resignFirstResponder];
    return NO;
}
- (void)CancelTask{
    [self.navigationController popViewControllerAnimated:YES];
}

//Fontion liée au pickerView


- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mesResultat count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [mesResultat[row] valueForKey:@"title"];
    
}
//Recuperation d'un objet a la ligne selectionner
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _unProjet = [mesResultat objectAtIndex:row];
}

#pragma mark - Navigation


//If some cell are not fill save will not redirect to the root view
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"newProjectSegue"]){
        if ([_titleField.text length]>0 && _duedate.date) {
            [self createTask];
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty field"
                                                            message:@"You must fill in the Title"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
    }
    return YES;
    
}

@end
