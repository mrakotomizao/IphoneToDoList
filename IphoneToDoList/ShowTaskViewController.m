//
//  ShowTaskViewController.m
//  ToDoList
//
//  Created by Seheno Rakotomizao on 24/02/2015.
//  Copyright (c) 2015 Seheno Rakotomizao. All rights reserved.
//

#import "ShowTaskViewController.h"
#import "ListProjectViewController.h"

@interface ShowTaskViewController ()

@end

@implementation ShowTaskViewController{
    NSString *progvalue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];
    
    _titleField.text = [_uneTache valueForKey:@"title"];
    if ([_uneTache valueForKey:@"purcent"]) {
        _purcent.text = [[_uneTache valueForKey:@"purcent"] stringValue];
    }
    //conversion d'une date en string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+1:00"]];
    
    NSString *duedate = [formatter stringFromDate:[_uneTache valueForKey:@"duedate"]];
    _progression = @[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100"];
    _dueDate.text = duedate;
    self.tableView.tableFooterView = [UIView new];
}
-(void)UpdateTask{
    NSManagedObject* modifyTask = (NSManagedObject *)_uneTache;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *purcentFromString = [f numberFromString:progvalue];
    NSLog(@"%@",progvalue);

    [modifyTask setValue:purcentFromString forKey:@"purcent"];
    
    NSMutableSet *tasks = [_unProjet mutableSetValueForKey:@"tasks"];
    [tasks addObject:modifyTask];
    
    // Save Managed Object Context
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_progression count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _progression[row];
}
//Recuperation d'un objet a la ligne selectionner
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    progvalue = [_progression objectAtIndex:row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"modifySegue"]){
        [self UpdateTask];
    }
}

@end
