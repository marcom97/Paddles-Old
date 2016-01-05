//
//  MyScene.h
//  eljueguito mio
//

//  Copyright (c) 2014 mac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameOver.h"
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *ball;
    SKSpriteNode *home;
    SKSpriteNode *retry;
    int count;
    BOOL start;
    BOOL isPlaying;
    CGPoint location;
    AVAudioPlayer *player;
    SKSpriteNode *retryConstraint;
    SKSpriteNode *homeConstraint;

}
@property (nonatomic) int score;
@property NSString *leaderboardIdentifier;

@property (nonatomic) SKSpriteNode *paddle;
@property (nonatomic) SKSpriteNode *paddleup;
@property (nonatomic) SKSpriteNode *paddleleft;
@property (nonatomic) SKSpriteNode *paddleright;
@property (nonatomic)  SKLabelNode* scoreLabel;

-(void)reportScore;

@end
