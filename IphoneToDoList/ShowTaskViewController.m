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

@implementation ShowTaskViewController

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
    NSArray * progression = @[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100"];
    _dueDate.text = duedate;
    self.tableView.tableFooterView = [UIView new];
}
-(void)UpdateTask{
    NSManagedObject* modifyTask = (NSManagedObject *)_uneTache;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *purcentFromString = [f numberFromString:_purcent.text];

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
