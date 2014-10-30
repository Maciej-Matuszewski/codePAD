//
//  SelectFileViewController.m
//  codePad
//
//  Created by Maciej Matuszewski on 26.10.2014.
//  Copyright (c) 2014 Maciej Matuszewski. All rights reserved.
//

#import "SelectFileViewController.h"
#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>

@interface SelectFileViewController ()

@end

@implementation SelectFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localView.layer.cornerRadius = 20;
    self.localView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.localView.layer.borderWidth = 3;
    
    self.dropboxView.layer.cornerRadius = 20;
    self.dropboxView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.dropboxView.layer.borderWidth = 3;
    
    self.icloudView.layer.cornerRadius = 20;
    self.icloudView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.icloudView.layer.borderWidth = 3;
    
    self.moreView.layer.cornerRadius = 20;
    self.moreView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moreView.layer.borderWidth = 3;
}

- (IBAction)dropbox{
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }else{
        [self performSegueWithIdentifier:@"goToDropbox" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
