//
//  menu.m
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//


#import "Menu.h"
#import "MyScene.h"
#import "CircularScene.h"
#import "ViewController.h"
#import "GCHelper.h"
#import "SKButton.h"

static const uint32_t ballcategory = 1;
static const uint32_t paddlecategory = 2;
static const uint32_t bordercategory = 4;

SKSpriteNode *foreground;

@implementation menu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"Title"];
        title.zPosition = 6;
        title.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height - self.size.height/3);
        [self addChild:title];
        
        SKSpriteNode *Background = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        Background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:Background];
        
        foreground = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground"];
        foreground.zPosition = 2;
        foreground.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:foreground];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = bordercategory ;
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self ;
        
        [self addBall];
        [self addPlayer];
        [self addPlayer2:size];
        [self addPlayer4:size];
        [self addPlayer3:size];
        
        SKButton *play = [[SKButton alloc]initWithImageNamedNormal:@"Play" selected:@"PlaySelected"];
        SKButton *leaderboards = [[SKButton alloc]initWithImageNamedNormal:@"Leaderboards" selected:@"LeaderboardsSelected"];
        
        play.zPosition = 7;
        leaderboards.zPosition = 7;
 
        
        play.position = CGPointMake(self.size.width/3, self.size.height/4);
        leaderboards.position = CGPointMake(self.size.width-self.size.width/3, self.size.height/4);
        
        [play setTouchUpInsideTarget:self action:@selector(playButton)];
        [leaderboards setTouchUpInsideTarget:self action:@selector(leaderboardsButton)];
        
        [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else{
                _leaderboardIdentifier = leaderboardIdentifier;
            }
        }];
        
        [self addChild:play];
        [self addChild:leaderboards];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        int count;
        count++;
        if (count > 1)
        {
            _location = [touch locationInNode:self];
        }
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        _endLocation = [touch locationInNode:self];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    
    
    
    if (contact.bodyA.categoryBitMask == paddlecategory) {
        SKAction *playSFX = [SKAction playSoundFileNamed:@"bounce 2.caf" waitForCompletion:NO];
        [self runAction:playSFX];
        
        
    }
    
    if (contact.bodyB.categoryBitMask == paddlecategory) {
        SKAction *playSFX = [SKAction playSoundFileNamed:@"bounce 2.caf" waitForCompletion:NO];
        [self runAction:playSFX];
    }
    
    if (contact.bodyA.categoryBitMask == paddlecategory) {
        
        
    }
    
    if (contact.bodyB.categoryBitMask == paddlecategory) {
        
    }
}

- (void)addBall {
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
    
    ball.zPosition = 4;
    
    ball.position = CGPointMake(self.size.width/2,self.size.height/2);;
    
    
    
    ball.physicsBody.dynamic = true;
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:27/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.categoryBitMask = ballcategory ;
    ball.physicsBody.contactTestBitMask = paddlecategory | bordercategory;
    
    
    [self addChild:ball];
    
    int ballForce = arc4random()%4;
    CGVector force;
    
    switch (ballForce) {
        case 0:
            force = CGVectorMake(-4, 4);
            break;
            
        case 1:
            force = CGVectorMake(-4, -4);
            break;
            
        case 2:
            force = CGVectorMake(4, -4);
            break;
            
        case 3:
            force = CGVectorMake(4, 4);
            break;
            
        default:
            break;
    }
    
    [ball.physicsBody applyImpulse:force];
    
}

-(void) addPlayer  {
    
    
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];

    self.paddle.position = CGPointMake(self.size.width/2,12.5);
    
    self.paddle.zPosition = 4;
    
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.zRotation = M_PI/2;
    self.paddle.physicsBody.categoryBitMask = paddlecategory;
    
    
    [self addChild:self.paddle];
}

-(void) addPlayer2:(CGSize)size  {
    
    
    self.paddleup = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];
    self.paddleup.position = CGPointMake(size.width/2,self.size.height-12.5);
    
    self.paddleup.zPosition = 4;

    
    self.paddleup.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleup.physicsBody.dynamic = NO;
    self.paddleup.zRotation = -M_PI/2;
    self.paddleup.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleup];
}

-(void) addPlayer3:(CGSize)size  {
    
    
    self.paddleleft = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];

    self.paddleleft.position = CGPointMake(12.5,size.height/2);
    
    self.paddleleft.zPosition = 4;
    
    self.paddleleft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleleft.physicsBody.dynamic = NO;
    
    self.paddleleft.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleleft];
}

-(void) addPlayer4:(CGSize)size  {
    
    
    self.paddleright = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];

    
    self.paddleright.position = CGPointMake(307.5,size.height/2);
    
    self.paddleright.zPosition = 4;
    
    self.paddleright.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleright.physicsBody.dynamic = NO;
    self.paddleright.zRotation = M_PI;
    
    self.paddleright.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleright];
}

- (void)update:(NSTimeInterval)currentTime
{
    self.paddle.position = CGPointMake(ball.position.x, 12.5);
    self.paddleup.position = CGPointMake(ball.position.x, self.size.height-12.5);
    self.paddleleft.position = CGPointMake(12.5, ball.position.y);
    self.paddleright.position = CGPointMake(307.5, ball.position.y);
    
    foreground.zRotation -= M_PI/360;
}

-(void)playButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
    SKScene *scene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:scene];
    
}

-(void)leaderboardsButton
{
        if([GCHelper sharedInstance].gameCenterEnabled)
        {
            [[GCHelper sharedInstance]showLeaderboardAndAchievements:YES viewController:self.view.window.rootViewController];
        }
}

@end