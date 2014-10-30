//
//  ViewController.m
//  CYRTextViewExample
//
//  Created by Illya Busigin on 1/5/14.
//  Copyright (c) 2014 Cyrillian, Inc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) QEDTextView *textView;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSLog(@"%@",basePath);
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ad.viewController = self;
    
    self.navigationItem.title = @"[codePAD];";
    [self navPanelViewInit];
    [self textViewInit:@"left"];
    [self textViewInit:@"right"];
    [self resizeBallInit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self functionBallsInit];
    
    //[self load:@"left" toFile:@"text.h"];
    //[self load:@"right" toFile:@"text.x"];
    
    
    /*/
     
     
     -(void)codeDragPanelChangeValues{
     if ([self.btn001.titleLabel.text isEqualToString:@"{ }"]) {
     [self.btn001 setTitle:@"+" forState:UIControlStateNormal];
     [self.btn002 setTitle:@"-" forState:UIControlStateNormal];
     [self.btn003 setTitle:@"*" forState:UIControlStateNormal];
     [self.btn004 setTitle:@"/" forState:UIControlStateNormal];
     [self.btn005 setTitle:@"=" forState:UIControlStateNormal];
     [self.btn006 setTitle:@"%" forState:UIControlStateNormal];
     [self.btn007 setTitle:@"<" forState:UIControlStateNormal];
     [self.btn008 setTitle:@">" forState:UIControlStateNormal];
     }else{
     [self.btn001 setTitle:@"{ }" forState:UIControlStateNormal];
     [self.btn002 setTitle:@"[ ]" forState:UIControlStateNormal];
     [self.btn003 setTitle:@"( )" forState:UIControlStateNormal];
     [self.btn004 setTitle:@"." forState:UIControlStateNormal];
     [self.btn005 setTitle:@";" forState:UIControlStateNormal];
     [self.btn006 setTitle:@"\\" forState:UIControlStateNormal];
     [self.btn007 setTitle:@"!" forState:UIControlStateNormal];
     [self.btn008 setTitle:@"//" forState:UIControlStateNormal];
     }
     
     }
     //*/
    
    self.codeDragPanel1 = [self codeDragPanelInitWithBtn001:@"+" Btn002:@"-" Btn003:@"*" Btn004:@"/" Btn005:@"=" Btn006:@"%" Btn007:@"<" Btn008:@">"withSide:@"left"];
    [self.view addSubview:self.codeDragPanel1];
    
    self.codeDragPanel2 = [self codeDragPanelInitWithBtn001:@"{ }" Btn002:@"[ ]" Btn003:@"{ }" Btn004:@"." Btn005:@";" Btn006:@"\\" Btn007:@"!" Btn008:@"//"withSide:@"right"];
    [self.view addSubview:self.codeDragPanel2];
    
    
}

-(void)save:(NSString *)side toFile:(NSString *)file{
    
    
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:file];
    
    NSString *content = @"Testx";
    
    [content writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    
    
}



-(void)load:(NSString *)side fromFile:(NSString *)file{
    
    
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:file];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        if ([side isEqualToString:@"left"]) {
            [self.leftText setText:[NSString stringWithContentsOfFile:fileName encoding:NSStringEncodingConversionAllowLossy error:nil]];
            [self.leftFileName setTitle:file forState:UIControlStateNormal];
        }else{
            [self.rightText setText:[NSString stringWithContentsOfFile:fileName encoding:NSStringEncodingConversionAllowLossy error:nil]];
            [self.rightFileName setTitle:file forState:UIControlStateNormal];
        }
    }
}

-(void)lrViewsMove:(UIPanGestureRecognizer *)pan{
    if ([pan locationInView:self.view.superview].x>20 && [pan locationInView:self.view.superview].x<self.view.frame.size.width-20) {
        [self.leftText setFrame:CGRectMake(self.leftText.frame.origin.x, self.leftText.frame.origin.y, [pan locationInView:self.view.superview].x-2, self.leftText.frame.size.height)];
        [self.rightText setFrame:CGRectMake([pan locationInView:self.view.superview].x+2, self.rightText.frame.origin.y,self.view.frame.size.width - [pan locationInView:self.view.superview].x-2, self.rightText.frame.size.height)];
        [self.resizeBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, 20)];
        [self.panel1Ball setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.panel1Ball.center.y)];
        [self.panel2Ball setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.panel2Ball.center.y)];
        [self.saveBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.saveBall.center.y)];
        [self.undoBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.undoBall.center.y)];
        [self.selectAllBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.selectAllBall.center.y)];
        [self.copyyBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.copyyBall.center.y)];
        [self.pasteBall setCenter:CGPointMake([pan locationInView:self.view.superview].x, self.pasteBall.center.y)];
    }
    
}

-(void)resizeBallInit{
    int s = 20;
    self.resizeBall = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-s, -s, 2*s, 4*s)];
    self.resizeBall.layer.cornerRadius = s;
    [self.resizeBall setBackgroundColor:[UIColor darkGrayColor]];
    UILabel *dragLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2*s, 2*s, s)];
    [dragLabel setText:@"III"];
    [dragLabel setTextColor:[UIColor whiteColor]];
    [dragLabel setFont:[UIFont systemFontOfSize:40]];
    dragLabel.textAlignment = NSTextAlignmentCenter;
    [self.resizeBall addSubview:dragLabel];
    [self.view addSubview:self.resizeBall];
    
    [self.resizeBall addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lrViewsMove:)]];
}

-(void)functionBallsInit{
    
    self.panel1Ball = [self functionBallwithLabel:@"[1]" onPoint:60 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.panel1Ball];
    
    self.panel2Ball = [self functionBallwithLabel:@"[2]" onPoint:100 withFunction:@selector(codeDragPanelHide2)];
    [self.view addSubview:self.panel2Ball];
    
    self.saveBall = [self functionBallwithLabel:@"Save" onPoint:140 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.saveBall];
    
    self.undoBall = [self functionBallwithLabel:@"Undo" onPoint:180 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.undoBall];
    
    self.selectAllBall = [self functionBallwithLabel:@"S_All" onPoint:220 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.selectAllBall];
    
    self.copyyBall = [self functionBallwithLabel:@"Copy" onPoint:260 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.copyyBall];
    
    self.pasteBall = [self functionBallwithLabel:@"Paste" onPoint:300 withFunction:@selector(codeDragPanelHide1)];
    [self.view addSubview:self.pasteBall];
    
}

-(UIView *)functionBallwithLabel:(NSString *)title onPoint:(NSInteger)point withFunction:(SEL)functionName{
    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(self.resizeBall.frame.origin.x, point, 40, 40)];
    ball.layer.cornerRadius = 20;
    [ball setBackgroundColor:[UIColor darkGrayColor]];
    
    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [tapLabel setText:title];
    [tapLabel setTextAlignment:NSTextAlignmentCenter];
    [tapLabel setTextColor:[UIColor whiteColor]];
    [tapLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [ball addSubview:tapLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:functionName];
    tapGesture.numberOfTapsRequired=1;
    [ball addGestureRecognizer:tapGesture];
    
    return ball;
}

-(void)textViewInit:(NSString *)side{
    
    if([side isEqualToString:@"left"]){
        self.leftText = [[QEDTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2-2, self.view.frame.size.height)];
        [self.leftText setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85]];
        self.leftText.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.leftText.delegate = self;
        
        [self.view addSubview:self.leftText];
        
    }else if([side isEqualToString:@"right"]){
        self.rightText = [[QEDTextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+4, 0, self.view.frame.size.width/2-2, self.view.frame.size.height)];
        [self.rightText setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85]];
        
        self.rightText.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.rightText.delegate = self;
        
        [self.view addSubview:self.rightText];
        
    }
    
}

-(UIView *)codeDragPanelInitWithBtn001:(NSString*)btn001Title Btn002:(NSString*)btn002Title Btn003:(NSString*)btn003Title Btn004:(NSString*)btn004Title Btn005:(NSString*)btn005Title Btn006:(NSString*)btn006Title Btn007:(NSString*)btn007Title Btn008:(NSString*)btn008Title withSide:(NSString*)side{
    int pointX = 150;
    if ([side isEqualToString:@"right"]) pointX =self.view.frame.size.width-pointX-200;
    UIView *panel = [[UIView alloc] initWithFrame:CGRectMake(pointX, self.view.frame.size.height-300, 200, 200)];
    [panel setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.85]];
    panel.layer.borderWidth = 3.0f;
    panel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    panel.layer.cornerRadius = 100;
    panel.clipsToBounds = YES;
    
    
    self.btn001 = [[UIButton alloc] initWithFrame:CGRectMake(100-25, 100-25-70, 50, 50)];
    [self.btn001 setTitle:btn001Title forState:UIControlStateNormal];
    [self.btn001 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn001.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn001 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn001];
    
    self.btn002 = [[UIButton alloc] initWithFrame:CGRectMake(100-25+50, 100-25-50, 50, 50)];
    [self.btn002 setTitle:btn002Title forState:UIControlStateNormal];
    [self.btn002 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn002.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn002 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn002];
    
    self.btn003 = [[UIButton alloc] initWithFrame:CGRectMake(100-25+70, 100-25, 50, 50)];
    [self.btn003 setTitle:btn003Title forState:UIControlStateNormal];
    [self.btn003 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn003.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn003 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn003];
    
    self.btn004 = [[UIButton alloc] initWithFrame:CGRectMake(100-25+50, 100-25+50, 50, 50)];
    [self.btn004 setTitle:btn004Title forState:UIControlStateNormal];
    [self.btn004 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn004.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn004 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn004];
    
    self.btn005 = [[UIButton alloc] initWithFrame:CGRectMake(100-25, 100-25+70, 50, 50)];
    [self.btn005 setTitle:btn005Title forState:UIControlStateNormal];
    [self.btn005 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn005.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn005 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn005];
    
    self.btn006 = [[UIButton alloc] initWithFrame:CGRectMake(100-25-50, 100-25+50, 50, 50)];
    [self.btn006 setTitle:btn006Title forState:UIControlStateNormal];
    [self.btn006 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn006.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn006 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn006];
    
    self.btn007 = [[UIButton alloc] initWithFrame:CGRectMake(100-25-70, 100-25, 50, 50)];
    [self.btn007 setTitle:btn007Title forState:UIControlStateNormal];
    [self.btn007 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn007.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn007 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn007];
    
    self.btn008 = [[UIButton alloc] initWithFrame:CGRectMake(100-25-50, 100-25-50, 50, 50)];
    [self.btn008 setTitle:btn008Title forState:UIControlStateNormal];
    [self.btn008 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btn008.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [self.btn008 addTarget:self action:@selector(inputFromDragPanel:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:self.btn008];
    
    
    UIView *panelDrager = [[UIView alloc] initWithFrame:CGRectMake(60, 60, 80, 80)];
    panelDrager.layer.cornerRadius = 40;
    [panelDrager setBackgroundColor:[UIColor darkGrayColor]];
    [panel addSubview:panelDrager];
    
    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [tapLabel setText:@"TAB"];
    [tapLabel setTextAlignment:NSTextAlignmentCenter];
    [tapLabel setTextColor:[UIColor whiteColor]];
    [tapLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [panelDrager addSubview:tapLabel];
    
    UIPanGestureRecognizer *codeDragPanelPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(codeDragPanelMove:)];
    
    [panelDrager addGestureRecognizer:codeDragPanelPanGesture];
    
    UITapGestureRecognizer *codeDragPanelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelSingleTap)];
    codeDragPanelTapGesture.numberOfTapsRequired=1;
    [panelDrager addGestureRecognizer:codeDragPanelTapGesture];
    
    return panel;
}
-(void)panelSingleTap{
    if ([self.leftText isFirstResponder]){
        NSUInteger location = self.leftText.selectedRange.location;
        [self.leftText setText: [NSString stringWithFormat:@"%@\t%@", [self.leftText.text substringToIndex:location], [self.leftText.text substringFromIndex:location]]];
        
        self.leftText.selectedRange = NSMakeRange(location+1, 0);
        
        
    }else if ([self.rightText isFirstResponder]){
        NSUInteger location = self.rightText.selectedRange.location;
        [self.rightText setText: [NSString stringWithFormat:@"%@\t%@", [self.rightText.text substringToIndex:location], [self.rightText.text substringFromIndex:location]]];
        
        self.rightText.selectedRange = NSMakeRange(location+1, 0);
    }

}

-(void)inputFromDragPanel:(id)sender{
    UIButton *btnX = sender;
    NSString *input = btnX.titleLabel.text;
    if ([input containsString:@" "])input=[input stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([self.leftText isFirstResponder]){
        NSUInteger location = self.leftText.selectedRange.location;
        [self.leftText setText: [NSString stringWithFormat:@"%@%@%@", [self.leftText.text substringToIndex:location], input, [self.leftText.text substringFromIndex:location]]];
        
        if ([input isEqualToString:@"//"])self.leftText.selectedRange = NSMakeRange(location+2, 0);
        else self.leftText.selectedRange = NSMakeRange(location+1, 0);
        
        
    }else if ([self.rightText isFirstResponder]){
        NSUInteger location = self.rightText.selectedRange.location;
        [self.rightText setText: [NSString stringWithFormat:@"%@%@%@", [self.rightText.text substringToIndex:location], input, [self.rightText.text substringFromIndex:location]]];
        
        if ([input isEqualToString:@"//"])self.rightText.selectedRange = NSMakeRange(location+2, 0);
        else self.rightText.selectedRange = NSMakeRange(location+1, 0);
    }
    
    
}

-(void)codeDragPanelMove:(UIPanGestureRecognizer *)pan{
    if([pan locationInView:self.view].y>0)pan.view.superview.center =[pan locationInView:self.view];
}

-(void)codeDragPanelHide1{
    if (![self.codeDragPanel1 isHidden]) [self.codeDragPanel1 setHidden:YES];
    else [self.codeDragPanel1 setHidden:NO];
}

-(void)codeDragPanelHide2{
    if (![self.codeDragPanel2 isHidden]) [self.codeDragPanel2 setHidden:YES];
    else [self.codeDragPanel2 setHidden:NO];
}

-(void)navPanelViewInit{
    
    UIView *navPanelViewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    [navPanelViewLeft setBackgroundColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar addSubview:navPanelViewLeft];
    
    self.leftFileName = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 280, self.navigationController.navigationBar.frame.size.height)];
    [self.leftFileName setTitle:@"Select file" forState:UIControlStateNormal];
    self.leftFileName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.leftFileName.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [navPanelViewLeft addSubview:self.leftFileName];
    [self.leftFileName addTarget:self action:@selector(selectLeft) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightFileName = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-280-30, 0, 280, self.navigationController.navigationBar.frame.size.height)];
    [self.rightFileName setTitle:@"Select file" forState:UIControlStateNormal];
    self.rightFileName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightFileName.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [navPanelViewLeft addSubview:self.rightFileName];
    [self.rightFileName addTarget:self action:@selector(selectRight) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)saveBtnAction{
    [self save:@"left" toFile:self.leftFileName.titleLabel.text];
    [self save:@"right" toFile:self.rightFileName.titleLabel.text];
}

-(void)selectLeft{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] setSide:@"left"];
    [self performSegueWithIdentifier:@"selectFileSegue" sender:self];
    
}

-(void)selectRight{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] setSide:@"right"];
    [self performSegueWithIdentifier:@"selectFileSegue" sender:self];
    
}

#pragma mark - Notification Handlers

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    
    [self moveTextViewForKeyboard:aNotification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self moveTextViewForKeyboard:aNotification up:NO];
}


#pragma mark - Convenience

- (void)moveTextViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up
{
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrameLeft = self.leftText.frame;
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    newFrameLeft.size.height -= keyboardFrame.size.height * (up?1:-1);
    self.leftText.frame = newFrameLeft;
    CGRect newFrameRight = self.rightText.frame;
    newFrameRight.size.height -= keyboardFrame.size.height * (up?1:-1);
    self.rightText.frame = newFrameRight;
    if(self.codeDragPanel1.center.y>keyboardFrame.size.height)[self.codeDragPanel1 setCenter:CGPointMake(self.codeDragPanel1.center.x, 300)];
    if(self.codeDragPanel2.center.y>keyboardFrame.size.height)[self.codeDragPanel2 setCenter:CGPointMake(self.codeDragPanel2.center.x, 300)];
    [UIView commitAnimations];
}

- (void)dismissKeyboard
{
    [_textView resignFirstResponder];
}

@end
