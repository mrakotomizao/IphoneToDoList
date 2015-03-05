//
//  CustomCell.h
//  ToDoList
//
//  Created by Seheno Rakotomizao on 23/02/2015.
//  Copyright (c) 2015 Seheno Rakotomizao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *check;
@property (weak, nonatomic) IBOutlet UILabel *purcentLabel;

@end
