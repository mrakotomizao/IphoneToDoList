//
//  ProjectViewController.m
//  ToDoList
//
//  Created by Moïse Rakotomizao on 22/02/2015.
//  Copyright (c) 2015 bullsgates. All rights reserved.
//

#import "ProjectViewController.h"
#import "ListProjectViewController.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];
    self.navigationItem.hidesBackButton = YES;
    self.tableView.tableFooterView = [UIView new];
    CAGradientLayer *bgLayer = [backgroundLayer blueGradient];
    bgLayer.frame = self.tableView.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createProject{
        NSManagedObject *newProject;
        newProject = [NSEntityDescription insertNewObjectForEntityForName:@"Projects" inManagedObjectContext:context];
        [newProject setValue:_nameField.text forKey:@"title"];
        [context save:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
//If somme cell are not fill save will not redirect to the root view
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"backListProject"]){
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
    }
    if([identifier isEqualToString:@"goListProject"]){
        if ([_nameField.text length]>0) {
        [self createProject];
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
