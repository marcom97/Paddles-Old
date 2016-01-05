//
//  GCHelper.h
//  Paddles
//
//  Created by Marco Matamoros on 9/30/14.
//  Copyright (c) 2014 BlueStars Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

extern NSString *const PresentAuthenticationViewController;

@interface GCHelper : NSObject <GKGameCenterControllerDelegate> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterEnabled;
@property NSString *leaderboardIdentifier;
@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedInstance;

- (void)authenticateLocalPlayer:(UIViewController*)controller;
-(void)reportScore:(int)score;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard viewController:(UIViewController*) viewcontroller;
@end
