//
//  backgroundLayer.h
//  IphoneToDoList
//
//  Created by Seheno Rakotomizao on 07/03/2015.
//  Copyright (c) 2015 Moïse Rakotomizao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface backgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;

@end
