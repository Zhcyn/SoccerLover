//
//  CorrectAnswer.m
//  soccerBadgeQuiz
//
//  Created by Abiel Gutierrez on 9/3/12.
//  Copyright (c) 2012 ASFM. All rights reserved.
//

#import "CorrectAnswer.h"
#import "QuizViewViewController.h"


@interface CorrectAnswer ()

@end

@implementation CorrectAnswer

@synthesize next;
@synthesize pointsEarned;
@synthesize pointsBonus;
@synthesize bckgView;
@synthesize playerCelebrating;



-(IBAction)nextQuestion:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if (lifeNotif==TRUE)
    {
        NSString *bonusLife = [NSString stringWithFormat:@"答对7题奖励: 额外1点生命值!"];
        pointsBonus.text = bonusLife;
        lifeNotif=FALSE;
    }
    
    else if (fiftyNotif==TRUE)
    {
        NSString *bonusFifty = [NSString stringWithFormat:@"答对7题奖励: 50%正确跳过一题!"];
        pointsBonus.text = bonusFifty;
        fiftyNotif=FALSE;
    }
    else
    {
        NSString *bonusPoints = [NSString stringWithFormat:@"(%i 秒奖励时间)", timeBonus];
        pointsBonus.text = bonusPoints;
    }
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
            bckgImage = [UIImage imageNamed:@"correctBckg"];
        }else if(result.height == 568)
        {
            bckgImage = [UIImage imageNamed:@"correctBckg-568h"];
        }else{
            bckgImage = [UIImage imageNamed:@"correctBckg-568h"];
        }

    }
    
    bckgView.image = bckgImage;
    
    
    [next setHidden: YES];
    
    NSString *pointsGained = [NSString stringWithFormat:@"+ %i 分!", pointsAwarded];
    pointsEarned.text = pointsGained;
    
    //Players Array
    UIImage *aguero = [UIImage imageNamed:@"Aguero"];
    UIImage *cavani = [UIImage imageNamed:@"Cavani"];
    UIImage *costa = [UIImage imageNamed:@"Costa"];
    UIImage *gerrard = [UIImage imageNamed:@"Gerrard"];
    UIImage *giroud = [UIImage imageNamed:@"Giroud"];
    UIImage *higuain = [UIImage imageNamed:@"Higuain"];
    UIImage *huntelaar = [UIImage imageNamed:@"Huntelaar"];
    UIImage *messi = [UIImage imageNamed:@"messi"];
    UIImage *pirlo = [UIImage imageNamed:@"Pirlo"];
    UIImage *reus = [UIImage imageNamed:@"Reus"];
    UIImage *ribery = [UIImage imageNamed:@"Ribery"];
    UIImage *ronaldo = [UIImage imageNamed:@"Ronaldo"];
    UIImage *sturridge = [UIImage imageNamed:@"Sturridge"];
    UIImage *torres = [UIImage imageNamed:@"torres"];
    UIImage *totti = [UIImage imageNamed:@"Totti"];
    UIImage *vanpersie = [UIImage imageNamed:@"VanPersie"];
    UIImage *zlatan = [UIImage imageNamed:@"zlatan"];
    
    playerArray = [[NSArray alloc] initWithObjects:aguero, cavani, costa, gerrard, giroud, higuain, huntelaar, messi, pirlo, reus, ribery, ronaldo, sturridge, torres, totti, vanpersie, zlatan, nil];
    
    NSUInteger randomIndex = arc4random() % [playerArray count];
    
    playerCelebrating.image = [playerArray objectAtIndex:randomIndex];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    bonusNotification.text = @"";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
