//
//  DropboxTableViewController.m
//  codePad
//
//  Created by Maciej Matuszewski on 26.10.2014.
//  Copyright (c) 2014 Maciej Matuszewski. All rights reserved.
//

#import "DropboxTableViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "AppDelegate.h"
#import "FileTableViewCell.h"

@interface DropboxTableViewController () <DBRestClientDelegate>
@property (nonatomic, strong) DBRestClient *restClient;
- (IBAction)goUpTap:(id)sender;

@end
DBMetadata *fileList;
NSString *dbPath;
@implementation DropboxTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dbPath = @"/";
    self.navigationItem.title = dbPath;
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    [self.restClient loadMetadata:dbPath];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata *)metadata {
    fileList = metadata;
    [self.tableView reloadData];
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
}

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    NSLog(@"File loaded into path: %@", localPath);
    
    
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] viewController]load:[(AppDelegate *)[[UIApplication sharedApplication] delegate] side] fromFile:metadata.filename];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error {
    NSLog(@"There was an error loading the file: %@", error);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [fileList.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fileCell" forIndexPath:indexPath];
    if([[fileList.contents objectAtIndex:indexPath.row] isDirectory])[cell.iconFile setImage:[UIImage imageNamed:@"Folder"]];
    else [cell.iconFile setImage:[UIImage imageNamed:@"File"]];
    [cell.title setText:[[fileList.contents objectAtIndex:indexPath.row] filename]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[fileList.contents objectAtIndex:indexPath.row] isDirectory]){
        dbPath = [dbPath stringByAppendingString:[NSString stringWithFormat:@"%@/",[[fileList.contents objectAtIndex:indexPath.row] filename]]];
        
        self.navigationItem.title = dbPath;
        [self.restClient loadMetadata:dbPath];
        
    }else{
        
        NSString *file = [[fileList.contents objectAtIndex:indexPath.row] filename];
        
        [self.restClient loadFile:[dbPath stringByAppendingString:file] intoPath:[[NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:file]];
        
    }
}
//*/

//dbPath = [dbPath substringToIndex:dbPath.length-[array[array.count-2] length]-1];
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goUpTap:(id)sender {
    if (dbPath.length>2) {
        NSArray *array = [dbPath componentsSeparatedByString:@"/"];
        dbPath = [dbPath substringToIndex:dbPath.length-[array[array.count-2] length]-1];
        self.navigationItem.title = dbPath;
        [self.restClient loadMetadata:dbPath];
    }
    
}
@end
