//
//  GameOver.m
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "GameOver.h"
#import "MyScene.h"

@implementation GameOver

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKAction *endsound = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        [self runAction:endsound];
        self.backgroundColor = [SKColor blackColor];
        
        SKLabelNode *gameover = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        gameover.text = @"Game Over";
        gameover.fontColor = [SKColor whiteColor];
        gameover.fontSize = 50;
        gameover.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:gameover];
        
        
        SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        restart.text = @"Again";
        restart.fontColor = [SKColor whiteColor];
        restart.fontSize = 25;
        restart.position = CGPointMake(size.width/2, -50);
        
        SKAction *movement = [SKAction moveToY:(size.height/2 - 40) duration:2.0];
        [restart runAction:movement];
        
        
        [self addChild:restart];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:2]];
    
}


@end
