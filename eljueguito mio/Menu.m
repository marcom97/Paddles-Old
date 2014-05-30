//
//  menu.m
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//


#import "Menu.h"
#import "MyScene.h"

@implementation menu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Untitled-4"]];
        
    }
    
    SKLabelNode *gamename = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    gamename.text = @"Paddles";
    gamename.fontColor = [SKColor whiteColor];
    gamename.fontSize = 50;
    gamename.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:gamename];
    
    
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    play.text = @"Tap To PLay";
    play.fontColor = [SKColor whiteColor];
    play.fontSize = 25;
    play.position = CGPointMake(size.width/2, 190);
    
    [self addChild:play];
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:2]];
    
}


@end