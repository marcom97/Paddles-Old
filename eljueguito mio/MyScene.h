//
//  MyScene.h
//  eljueguito mio
//

//  Copyright (c) 2014 mac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameOver.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate>
{
    SKSpriteNode *ball;
    SKSpriteNode *home;
    SKSpriteNode *retry;
    int count;
    BOOL start;
    BOOL isPlaying;
    CGPoint location;
}
@property (nonatomic) int score;

@end
