//
//  IncorrectAnswer.m
//  soccerBadgeQuiz
//
//  Created by Abiel Gutierrez on 9/4/12.
//  Copyright (c) 2012 ASFM. All rights reserved.
//

#import "IncorrectAnswer.h"
#import "QuizViewViewController.h"

@interface IncorrectAnswer ()

@end

@implementation IncorrectAnswer

@synthesize next;
@synthesize incorrectLabel;
@synthesize numberOfLives;
@synthesize bckgView;

-(IBAction)nextQuestion:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) buttonShowing
{
    [next setHidden:NO];
}


-(void) viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(buttonShowing) withObject:nil afterDelay:0.4];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Screen Configuration
    UIImage *bckgImage;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            if(timeIsUp==FALSE)
            {
                bckgImage = [UIImage imageNamed:@"IncorrectBckg"];
            }
            else
            {
                bckgImage = [UIImage imageNamed:@"timeUp"];
            }
            
        }else if(result.height == 568)
        {
            if(timeIsUp==FALSE)
            {
                bckgImage = [UIImage imageNamed:@"IncorrectBckg-568h"];
            }
            else
            {
                bckgImage = [UIImage imageNamed:@"timeUp-568h"];
            }
        }else{
            if(timeIsUp==FALSE)
            {
                bckgImage = [UIImage imageNamed:@"IncorrectBckg-568h"];
            }
            else
            {
                bckgImage = [UIImage imageNamed:@"timeUp-568h"];
            }
        }
        
    }

    bckgView.image = bckgImage;
    
    
    [next setHidden: YES];
    
    if (timeIsUp == FALSE) {
        
        incorrectLabel.text = @"回答错误!";
    }
    else {
        incorrectLabel.text = @"时间到!";
    }
    
    if (lives==2)
    {
        numberOfLives.text = @"生命值还剩余2点。";
    }
    else if (lives==1)
    {
        numberOfLives.text = @"生命值还剩余1点。";
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
