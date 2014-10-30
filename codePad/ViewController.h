//
//  ViewController.h
//  CYRTextViewExample
//
//  Created by Illya Busigin on 1/5/14.
//  Copyright (c) 2014 Cyrillian, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QEDTextView.h"

@interface ViewController : UIViewController

@property (strong,nonatomic) UIView *codeDragPanel1;
@property (strong,nonatomic) UIView *codeDragPanel2;
@property (strong,nonatomic) UIView *resizeBall;


@property (strong,nonatomic) UIView *panel1Ball;
@property (strong,nonatomic) UIView *panel2Ball;
@property (strong,nonatomic) UIView *saveBall;
@property (strong,nonatomic) UIView *undoBall;
@property (strong,nonatomic) UIView *selectAllBall;
@property (strong,nonatomic) UIView *copyyBall;
@property (strong,nonatomic) UIView *pasteBall;


@property (strong,nonatomic) QEDTextView *leftText;
@property (strong,nonatomic) QEDTextView *rightText;

@property (strong, nonatomic) UIButton *leftFileName;
@property (strong, nonatomic) UIButton *rightFileName;

@property (strong,nonatomic) UIButton *btn001;
@property (strong,nonatomic) UIButton *btn002;
@property (strong,nonatomic) UIButton *btn003;
@property (strong,nonatomic) UIButton *btn004;
@property (strong,nonatomic) UIButton *btn005;
@property (strong,nonatomic) UIButton *btn006;
@property (strong,nonatomic) UIButton *btn007;
@property (strong,nonatomic) UIButton *btn008;

-(void)load:(NSString *)side fromFile:(NSString *)file;

@end
