//
//  CustomCell.h
//  ToDoList
//
//  Created by Moïse Rakotomizao on 23/02/2015.
//  Copyright (c) 2015 Moïse Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *check;
@property (weak, nonatomic) IBOutlet UILabel *purcentLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectName;

@end
