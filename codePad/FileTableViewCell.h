//
//  FileTableViewCell.h
//  codePad
//
//  Created by Maciej Matuszewski on 26.10.2014.
//  Copyright (c) 2014 Maciej Matuszewski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconFile;
@property (strong, nonatomic) IBOutlet UILabel *title;

@end
