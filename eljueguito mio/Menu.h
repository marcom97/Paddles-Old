//
//  menu.h
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface menu : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *ball;
    SKSpriteNode *play;
    SKSpriteNode *leaderboards;
    CGPoint location;
    CGPoint endLocation;
}

@property (nonatomic) SKSpriteNode *paddle;
@property (nonatomic) SKSpriteNode *paddleup;
@property (nonatomic) SKSpriteNode *paddleleft;
@property (nonatomic) SKSpriteNode *paddleright;

@end
