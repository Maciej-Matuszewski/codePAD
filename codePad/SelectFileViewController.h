//
//  SelectFileViewController.h
//  codePad
//
//  Created by Maciej Matuszewski on 26.10.2014.
//  Copyright (c) 2014 Maciej Matuszewski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectFileViewController : UIViewController
- (IBAction)cancelBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *localView;
@property (strong, nonatomic) IBOutlet UIView *dropboxView;
@property (strong, nonatomic) IBOutlet UIView *icloudView;
@property (strong, nonatomic) IBOutlet UIView *moreView;
@end
