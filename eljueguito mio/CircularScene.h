//
//  CircularScene.h
//  Paddles
//
//  Created by Marco Matamoros on 10/11/14.
//  Copyright (c) 2014 BlueStars Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameOver.h"
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import "SKButton.h"

@interface CircularScene : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *ball;
    SKSpriteNode *home;
    SKSpriteNode *retry;
    int count;
    BOOL start;
    BOOL isPlaying;
    CGPoint location;
    CGPoint endLocation;
    AVAudioPlayer *player;
    SKSpriteNode *retryConstraint;
    SKSpriteNode *homeConstraint;
    BOOL counterClockwise;
    BOOL clockwise;
    SKSpriteNode *leftButton;
    SKSpriteNode *rightButton;
    
}
@property (nonatomic) int score;
@property NSString *leaderboardIdentifier;

@property SKNode *center;

@property (nonatomic) SKSpriteNode *paddle;
@property (nonatomic) SKSpriteNode *paddleup;
@property (nonatomic) SKSpriteNode *paddleleft;
@property (nonatomic) SKSpriteNode *paddleright;
@property (nonatomic)  SKLabelNode* scoreLabel;

-(void)reportScore;


@end
