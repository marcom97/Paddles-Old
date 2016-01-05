//
//  menu.h
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "ViewController.h"

@interface menu : SKScene <SKPhysicsContactDelegate, GKGameCenterControllerDelegate>
{
    SKSpriteNode *ball;
}
@property CGPoint location;
@property CGPoint endLocation;


@property (nonatomic) SKSpriteNode *paddle;
@property (nonatomic) SKSpriteNode *paddleup;
@property (nonatomic) SKSpriteNode *paddleleft;
@property (nonatomic) SKSpriteNode *paddleright;
@property NSString *leaderboardIdentifier;

@end
