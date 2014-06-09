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
    BOOL start;
    BOOL isPlaying;
}
@property (nonatomic) int score;

@end
