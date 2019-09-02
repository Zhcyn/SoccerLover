//
//  NextLevel.m
//  soccerBadgeQuiz
//
//  Created by Abiel Gutierrez on 9/4/12.
//  Copyright (c) 2012 ASFM. All rights reserved.
//

#import "NextLevel.h"
#import "GameCenterManager.h"
#import "AppSpecificValues.h"

@interface NextLevel ()

@end

@implementation NextLevel

@synthesize bckgView;
@synthesize pointsEarned;
@synthesize message;
@synthesize nextQuestion;
@synthesize bonusNotification;
@synthesize gameCenterManager;
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
    [nextQuestion setHidden:NO];
}

//ACHIEVEMENTS
- (void) completeMultipleAchievements
{
    if (totalQuestions==50)
    {
        if (wrongAnswers==0)
        {
            GKAchievement *achievement1 = [[GKAchievement alloc] initWithIdentifier: kAchievementBeatFirst10];
            GKAchievement *achievement2 = [[GKAchievement alloc] initWithIdentifier: kAchievementBeatFirst10Perf];
            achievement1.percentComplete = 100.0;
            achievement1.showsCompletionBanner = YES;
            achievement2.percentComplete = 100.0;
            achievement2.showsCompletionBanner = YES;
            NSArray *achievementsToComplete = [NSArray arrayWithObjects:achievement1,achievement2, nil];
            [GKAchievement reportAchievements: achievementsToComplete withCompletionHandler:^(NSError *error)
             {
                 if (error != nil)
                 {
                     NSLog(@"Error in reporting achievements: %@", error);
                 }
             }];
        }
        else
        {
            GKAchievement *achievement1 = [[GKAchievement alloc] initWithIdentifier: kAchievementBeatFirst10];
            achievement1.percentComplete = 100.0;
            achievement1.showsCompletionBanner = YES;
            [achievement1 reportAchievementWithCompletionHandler:^(NSError *error)
             {
                 if (error != nil)
                 {
                     NSLog(@"Error in reporting achievements: %@", error);
                 }
             }];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"beatLevel10"];
        }
    }
}


-(void) viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(buttonShowing) withObject:nil afterDelay:0.4];
    
    if (lifeNotif==TRUE)
    {
        NSString *bonusLife = [NSString stringWithFormat:@"答对7题奖励: 额外1点生命值!"];
        bonusNotification.text = bonusLife;
        lifeNotif=FALSE;
    }
    
    else if (fiftyNotif==TRUE)
    {
        NSString *bonusFifty = [NSString stringWithFormat:@"答对7题奖励: 50%正确跳过一题!"];
        bonusNotification.text = bonusFifty;
        fiftyNotif=FALSE;
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"achieved10Perfects"] == YES && [[NSUserDefaults standardUserDefaults] boolForKey:@"rateAppStore"] == YES)
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"skipLevels"];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notifiedUser13"] != YES)
        {
            UIAlertView *unlockNotification;
            
            unlockNotification = [[UIAlertView alloc]
                                  initWithTitle:@"新功能解锁!"
                                  message:@"现在你可以在\"解锁\"页面选择跳过关卡1-3。"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles: nil];
            
            [unlockNotification show];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifiedUser13"];
        }
    }
    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"achieved10Perfects"] == YES && [[NSUserDefaults standardUserDefaults] boolForKey:@"notifiedAboutRating"] != YES)
    {
        UIAlertView *unlockNotification;
        
        unlockNotification = [[UIAlertView alloc]
                              initWithTitle:@"想直接跳过关卡1-3?"
                              message:@"现在去给我们一个评价，就可以直接在\"解锁\"页面选择跳过关卡1-3，从关卡4直接开始，并且获得360分。"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles: nil];
        
        [unlockNotification show];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifiedAboutRating"];
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self completeMultipleAchievements];
    
    //Screen Configuration
    UIImage *bckgImage = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            bckgImage = [UIImage imageNamed:@"correctBckg"];
        }else if(result.height == 568)
        {
            bckgImage = [UIImage imageNamed:@"correctBckg-568h"];
        }else {
            bckgImage = [UIImage imageNamed:@"correctBckg-568h"];
        }
        
    }
    
    bckgView.image = bckgImage;

    
    
    [nextQuestion setHidden: YES];
    
    NSString *pointsGained = [NSString stringWithFormat:@"+ %i 分!", pointsAwarded];
    pointsEarned.text = pointsGained;
    
    int nextLevel=2;
    
    if (totalQuestions<6) {
        nextLevel=2;
    }
    else if (totalQuestions<11) {
        nextLevel=3;
    }
   
    else if (totalQuestions<16) {
        nextLevel=4;
    }
    
    else if (totalQuestions<21) {
        nextLevel=5;
    }
    
    else if (totalQuestions<26) {
        nextLevel=6;
    }
    else if (totalQuestions<31) {
        nextLevel=7;
    }
    else if (totalQuestions<36) {
        nextLevel=8;
    }
    else if (totalQuestions<41) {
        nextLevel=9;
    }
    else if (totalQuestions<46) {
        nextLevel=10;
    }
    else if (totalQuestions<51) {
        nextLevel=11;
    }
    else if (totalQuestions<56) {
        nextLevel=12;
    }
    else if (totalQuestions<61) {
        nextLevel=13;
    }
    
    NSString *pointsAndLevel = [NSString stringWithFormat:@"进阶到关卡 %i!", nextLevel];
    message.text = pointsAndLevel;
    
    
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
    
    //Check for levels 1-3 being completed perfectly
    int timesLevels13Beaten0 = [[NSUserDefaults standardUserDefaults] integerForKey:@"timesLevels13Beaten"];
    
    if (totalQuestions == 15 && wrongAnswers==0)
    {
        
        int i = 1 + timesLevels13Beaten0;
        [[NSUserDefaults standardUserDefaults] setInteger: i forKey: @"timesLevels13Beaten"];
    }
    
    int timesLevels13Beaten = [[NSUserDefaults standardUserDefaults] integerForKey:@"timesLevels13Beaten"];
    
    if (timesLevels13Beaten > 9) 
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"achieved10Perfects"];
    }
    
    if (totalQuestions==50 && [[NSUserDefaults standardUserDefaults] boolForKey:@"likeFacebook"] == YES)
    {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"1113notif"] != YES)
        {
            UIAlertView *unlockNotification;
            
            unlockNotification = [[UIAlertView alloc]
                                  initWithTitle:@"新功能解锁!"
                                  message:@"你已经解锁了关卡11-13!"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles: nil];
            
            [unlockNotification show];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"1113notif"];
        }
    }
    
    if (totalQuestions == 50)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"beatLevel10"];
    }
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
