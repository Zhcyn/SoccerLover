//
//  Options.m
//  soccerBadgeQuiz
//
//  Created by Abiel Gutierrez on 1/6/13.
//  Copyright (c) 2013 ASFM. All rights reserved.
//

#import "Options.h"

@interface Options ()

@end

@implementation Options

@synthesize goBack;
@synthesize quizzesCompleted;
@synthesize highScore;
@synthesize reset;
@synthesize userOutput;
@synthesize theScroller;
@synthesize bckgView;
@synthesize buyDisableTimer;
@synthesize disableTimerSwitch;
@synthesize sound;

@synthesize gameCenterManager;
@synthesize currentLeaderBoard;
@synthesize facebook;
@synthesize restorePurchase;

InAppPurchaseManager* xyz = nil;

+ (void)initialize
{
    if(!xyz)
        xyz = [[InAppPurchaseManager alloc] init];
}


-(IBAction)requestInformation:(id)sender
{
    if([xyz canMakePurchases])
    {
        [xyz loadStore];
    }
    else
    {
        UIAlertView *purchaseAlertDialogue;
        
        purchaseAlertDialogue = [[UIAlertView alloc]
                         initWithTitle:@"错误"
                         message:@"系统设置禁止游戏内购买项目！"
                         delegate:self
                         cancelButtonTitle:@"确定"
                         otherButtonTitles: nil];
        
        [purchaseAlertDialogue show];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)goHome:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)goToFacebook:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"fb://profile/5951537"];
    [[UIApplication sharedApplication] openURL:url];
}


-(void)resetScores
{
    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey: @"quizzesComplete"];
    [[NSUserDefaults standardUserDefaults] setInteger: 0 forKey: @"highscore"];
    
    NSString *hs = [NSString stringWithFormat:@"最好成绩: %i", [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]];
    highScore.text = hs;
    
    NSString *qc = [NSString stringWithFormat:@"答题完毕: %i", [[NSUserDefaults standardUserDefaults] integerForKey:@"quizzesComplete"]];
    quizzesCompleted.text = qc;
}


- (void) alertView:(UIAlertView *) alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex: buttonIndex] isEqualToString:@"Yes"])
    {
		[self resetScores];
	}
}


-(IBAction)resetAlert:(id)sender
{
	
	UIAlertView *alertDialogue;
	
	alertDialogue = [[UIAlertView alloc]
					 initWithTitle:@"重置数据"
					 message:@"你确定要重置所有数据吗？这会抹掉最好成绩和答题完成次数。"
					 delegate:self
					 cancelButtonTitle:@"不"
					 otherButtonTitles:@"是的", nil];
	
	[alertDialogue show];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if(disableTimerSwitch.isOn == TRUE)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"switchState" ];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"switchState" ];
    }
    
    if(sound.isOn == TRUE)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundWanted" ];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"soundWanted" ];
    }
}

//////RESTORE DISABLE TIMER IAP//////
-(IBAction) restoreIAP:(id)sender
{
    [xyz restoreIAP2];
}

////LEADERBOARD////
- (IBAction) showLeaderboard
{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != NULL)
    {
        leaderboardController.category = self.currentLeaderBoard;
        leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}

/////ACHIEVEMENTS/////
- (IBAction) showAchievements
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != NULL)
    {
        achievements.achievementDelegate = self;
        [self presentModalViewController: achievements animated: YES];
    }
}
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController;
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
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
            bckgImage = [UIImage imageNamed:@"UnlocksBckg"];
        }else if (result.height == 568){
            bckgImage = [UIImage imageNamed:@"OptionsBckg-568h"];
        }else{
            bckgImage = [UIImage imageNamed:@"OptionsBckg-568h"];
        }
//        if(result.height == 568)
//        {
//            bckgImage = [UIImage imageNamed:@"OptionsBckg-568h"];
//        }
    }
    
    bckgView.image = bckgImage;
    
    [theScroller setScrollEnabled:YES];
    [theScroller setContentSize:CGSizeMake(320, 628)];
  
   
    //HighScores and QuizzesCompleted    
    NSString *hs = [NSString stringWithFormat:@"最好成绩: %i", [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]];
    highScore.text = hs;
    
    NSString *qc = [NSString stringWithFormat:@"答题完毕: %i", [[NSUserDefaults standardUserDefaults] integerForKey:@"quizzesComplete"]];
    quizzesCompleted.text = qc;
    
    //Disable Timer IAP
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"switchState"] == YES)
    {
        [disableTimerSwitch setOn:YES];
    }
    else
    {
        [disableTimerSwitch setOn:NO];
    }
    
    if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"isDisableTimerPurchased"] == YES)
    {
        [buyDisableTimer setHidden:YES];
        [disableTimerSwitch setHidden:NO];
    }
    else
    {
        [buyDisableTimer setHidden:NO];
        [disableTimerSwitch setHidden:YES];
        [disableTimerSwitch setOn:NO animated:NO];
    }
    
    if( disableTimerSwitch.isOn == TRUE)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"switchState" ];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"switchState" ];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isDisableTimerPurchased"] == YES)
    {
        [restorePurchase setHidden:YES];
    }
    else
    {
          [restorePurchase setHidden:NO];
    }
    


    
    //////Sound configuration//////
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"soundWanted"] == YES)
    {
        [sound setOn:YES];
    }
    else
    {
        [sound setOn:NO];
    }
    
    if( sound.isOn == TRUE)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundWanted" ];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"soundWanted" ];
    }
    
    //GameCenter Leaderboard ID
    self.currentLeaderBoard = kLeaderboardID;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
