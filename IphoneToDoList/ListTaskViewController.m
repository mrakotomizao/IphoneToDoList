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
    CAGradientLayer *bgLayer = [backgroundLayer blueGradient];
    bgLayer.frame = self.tableView.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    [self AllTask];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    if(_unProjet!=nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"project = %@", _unProjet];
        [request setPredicate:predicate];
    }
    [request setEntity:allTasks];
    
    NSError *error;
    _mesResultat = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error.description);
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
    if ([purcent intValue] == 100) {
        cell.check.image = [UIImage imageNamed:@"Checkbox25.png"];
    }
    if ([numberConverted length] > 0 && purcent!=nil) {
        cell.purcentLabel.text = numberConverted;
    }else{
        cell.purcentLabel.text = @"0%";
    }
    if(_unProjet==nil){
        cell.projectName.text = [[unProjet valueForKey:@"Project"] valueForKey:@"title"];
    }else{
        cell.projectName.text = @"";
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
