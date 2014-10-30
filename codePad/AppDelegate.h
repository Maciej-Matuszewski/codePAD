//
//  AppDelegate.h
//  codePad
//
//  Created by Maciej Matuszewski on 24.10.2014.
//  Copyright (c) 2014 Maciej Matuszewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) NSString *side;


@end

