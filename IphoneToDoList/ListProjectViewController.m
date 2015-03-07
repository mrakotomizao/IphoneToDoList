//
//  ProjectViewController.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 21/02/2015.
//  Copyright (c) 2015 Bullsgates. All rights reserved.
//

#import "ListProjectViewController.h"


@interface ListProjectViewController ()

@end

@implementation ListProjectViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    CAGradientLayer *bgLayer = [backgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"Liste des projets";
    [self setLocalBadgeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Create a Reminder Notification
- (void) setReminderLocal{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
    localNotification.alertBody = @"Your alert message";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
//Create a badge Notification
-(void)setLocalBadgeNotification{
    NSEntityDescription *entityTasks = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    //Get current date
    
    
    NSDate *date = [NSDate date];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"purcent < 100 and duedate <= %@", date];
    [request setPredicate:predicate];
    [request setEntity:entityTasks];
    NSError *error;
    NSArray * mesResultat = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error.description);
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = (NSInteger)mesResultat.count;

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self AllProject] count];
}
-(id)AllProject{
    NSEntityDescription *newVoiture = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:newVoiture];
    
    NSError *error;
    NSArray * mesResultat = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error.description);
    }
    return mesResultat;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"uniqueID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSManagedObjectContext *unProjet = [[self AllProject] objectAtIndex:indexPath.row];
    cell.textLabel.text = [unProjet valueForKey:@"title"];
    cell.backgroundColor = [UIColor colorWithRed:0 green:0.4 blue:0.8 alpha:0.5];
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showTasksSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        ListTaskViewController *controller = (ListTaskViewController *)navController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        controller.unProjet = [[self AllProject] objectAtIndex:indexPath.row];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
