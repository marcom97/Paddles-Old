//
//  ViewController.h
//  eljueguito mio
//

//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "GADBannerView.h"

@class GADBannerView;

@interface ViewController : UIViewController <GKGameCenterControllerDelegate, GADBannerViewDelegate>

@property GADBannerView *adBanner;

@property (nonatomic) BOOL adsenabled;
@property BOOL gameCenterEnabled;
@property NSString *leaderboardIdentifier;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;
-(void)setAdsenabled:(BOOL)adsenabled;

@end
