//
//  ListTaskViewController.m
//  SidebarDemo
//
//  Created by Moïse Rakotomizao on 21/02/2015.
//  Copyright (c) 2015 bullsgate. All rights reserved.
//

#import "ListTaskViewController.h"
#import "SWRevealViewController.h"
#import "ShowTaskViewController.h"
#import "CustomCell.h"

@interface ListTaskViewController ()

@end

@implementation ListTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self AllTask];
    self.title = [_unProjet valueForKey:@"title"];
    
    //NSLog(@"%@",[self AllTask]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Observer New Note

-(void)AllTask{
    NSEntityDescription *allTasks = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"project = %@", _unProjet];
    [request setPredicate:predicate];
    [request setEntity:allTasks];
    
    
    
    NSError *error;
    _mesResultat = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error.description);
    }
}
- (void)organizeToDolist{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    
    //Current Date
    NSDate *currentDate = [NSDate date];
    
    _overdueTasks = nil;
    _mustdoTasksOrange = nil;
    _mustdoTasksGreen = nil;
    _completedTasks = nil;
    for(NSManagedObject *toDoTask in _mesResultat)
    {
        /* COMPLETED */
        if((NSNumber *)[toDoTask valueForKey:@"purcent"]==[NSNumber numberWithInt: 100]) [_completedTasks addObject:toDoTask];
        
        /* UNCOMPLETED */
        else
        {
            NSDate *dueDate = [toDoTask valueForKey:@"duedate"];
            
            components = [NSDateComponents new];
            [components setDay:-1];
            NSDate *threeDaysBefore = [calendar dateByAddingComponents:components
                                                                toDate:dueDate
                                                               options:0];
            
            if([dueDate earlierDate:currentDate] == dueDate){
                [self.overdueTasks addObject:toDoTask];
            } else if([currentDate laterDate:threeDaysBefore] == currentDate){ // Assumed < Tomorrow
                [self.mustdoTasksOrange addObject:toDoTask];
            } else if([currentDate laterDate:threeDaysBefore] == threeDaysBefore){
                [self.mustdoTasksGreen addObject:toDoTask];
            }
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_mesResultat count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"uniqueID";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSManagedObjectContext *unProjet = [_mesResultat objectAtIndex:indexPath.row];
    cell.titleLabel.text = [unProjet valueForKey:@"title"];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MM-yyyy"];
    
    //NSLOG
    cell.dueDateLabel.text = [outputFormatter stringFromDate:[unProjet valueForKey:@"duedate"]];
    NSNumber *purcent = [unProjet valueForKey:@"purcent"];
    NSString *numberConverted = [NSString stringWithFormat:@"%@%%",purcent];
    
    if ([numberConverted length] > 0 && purcent!=nil) {
        cell.purcentLabel.text = numberConverted;
    }else{
        cell.purcentLabel.text = @"0%";
    }
    
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showTaskSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        ShowTaskViewController *controller = (ShowTaskViewController *)navController.topViewController;
        NSIndexPath *indexPath = [_taskList indexPathForSelectedRow];
        
        controller.uneTache = [_mesResultat objectAtIndex:indexPath.row];
        controller.unProjet = _unProjet;
        
    }
}

@end
