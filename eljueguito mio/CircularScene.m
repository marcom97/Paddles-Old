//
//  CircularScene.m
//  Paddles
//
//  Created by Marco Matamoros on 10/11/14.
//  Copyright (c) 2014 BlueStars Studios. All rights reserved.
//

#import "CircularScene.h"
#import "GameOver.h"
#import "Menu.h"
#import "GCHelper.h"

static const uint32_t ballcategory = 1;
static const uint32_t leftpaddlecategory = 2;
static const uint32_t rightpaddlecategory = 4;
static const uint32_t uppaddlecategory = 6;
static const uint32_t downpaddlecategory = 8;
static const uint32_t bordercategory = 10;

@implementation CircularScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *Background = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        Background.position = CGPointMake(Background.size.width/2, Background.size.height/2);
        [self addChild:Background];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = bordercategory ;
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self ;
        
        [self addBall];
        [self addPlayer];
        [self addPlayer2:size];
        //[self addPlayer4:size];
        //[self addPlayer3:size];
        [self addscore:size];
        
        start = true;
        isPlaying = true;
        
        self.score = 0;
        
        leftButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1 alpha:0] size:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
        rightButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1 alpha:0] size:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
        
        leftButton.position = CGPointMake(leftButton.size.width/2, self.frame.size.height/2);
        rightButton.position = CGPointMake(self.frame.size.width - rightButton.size.width/2, self.frame.size.height/2);
        
        [self addChild:leftButton];
        [self addChild:rightButton];
        
        location = CGPointMake(-1, -1);

    }
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Untitled" ofType:@"mp3"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.numberOfLoops = -1;
    player.enableRate = TRUE;
    
    
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        
        location = [touch locationInNode:self];
        
        
        
    }
    
    if (start == true)
    {
        int ballForce = arc4random()%4;
        CGVector force;
        
        [player play];
        
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
        start = false;
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        endLocation = [touch locationInNode:self];
    }
    
    if (isPlaying)
    {
        location = CGPointMake(-1, -1);
    }
}


-(void) addscore:(CGSize)size{
    
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    _scoreLabel.fontSize = 35;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    _scoreLabel.fontColor = [UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.0];
    _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_scoreLabel];
    
}



-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    
    
    
    if (contact.bodyA.categoryBitMask == uppaddlecategory)
    {
        [self paddleContact];
        BOOL isMultipleOfFive = !(self.score % 5);
        
        
        
        if (isMultipleOfFive)
        {
            
            
            int ballForce = arc4random()%2;
            CGVector force;
            
            switch (ballForce)
            {
                case 0:
                    force = CGVectorMake(-2.5, -1);
                    break;
                    
                case 1:
                    force = CGVectorMake(2.5, -1);
                    break;
                    
                default:
                    break;
            }
            
            [ball.physicsBody applyImpulse:force];
        }
        
        
    }
    
    if (contact.bodyA.categoryBitMask == downpaddlecategory)
    {
        [self paddleContact];
        BOOL isMultipleOfFive = !(self.score % 5);
        
        
        
        if (isMultipleOfFive)
        {
            
            
            int ballForce = arc4random()%2;
            CGVector force;
            
            switch (ballForce)
            {
                case 0:
                    force = CGVectorMake(2.5, 1);
                    break;
                    
                case 1:
                    force = CGVectorMake(-2.5, 1);
                    break;
                    
                default:
                    break;
            }
            
            [ball.physicsBody applyImpulse:force];
        }
        
    }
    
    if (contact.bodyA.categoryBitMask == leftpaddlecategory)
    {
        [self paddleContact];
        BOOL isMultipleOfFive = !(self.score % 5);
        
        
        
        if (isMultipleOfFive)
        {
            
            
            int ballForce = arc4random()%2;
            CGVector force;
            
            switch (ballForce)
            {
                case 0:
                    force = CGVectorMake(1, -2.5);
                    break;
                    
                case 1:
                    force = CGVectorMake(1, 2.5);
                    break;
                    
                default:
                    break;
            }
            
            [ball.physicsBody applyImpulse:force];
        }
    }
    
    if (contact.bodyA.categoryBitMask == rightpaddlecategory)
    {
        [self paddleContact];
        BOOL isMultipleOfFive = !(self.score % 5);
        
        
        
        if (isMultipleOfFive)
        {
            
            
            int ballForce = arc4random()%2;
            CGVector force;
            
            switch (ballForce)
            {
                case 0:
                    force = CGVectorMake(-1, 2.5);
                    break;
                    
                case 1:
                    force = CGVectorMake(-1, -2.5);
                    break;
                    
                default:
                    break;
            }
            
            [ball.physicsBody applyImpulse:force];
        }
        
    }
    
    if (contact.bodyA.categoryBitMask == bordercategory)
    {
        [self gameover];
    }
}

- (void) addBall {
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
    
    ball.position = CGPointMake(self.size.width/2,self.size.height/2);;
    
    ball.physicsBody.dynamic = true;
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:27/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.05f;
    ball.physicsBody.categoryBitMask = ballcategory ;
    ball.physicsBody.contactTestBitMask = uppaddlecategory | leftpaddlecategory | downpaddlecategory | rightpaddlecategory |bordercategory;
    
    
    [self addChild:ball];
    
}

-(void)paddleContact
{
    SKAction *playSFX = [SKAction playSoundFileNamed:@"bounce 2.caf" waitForCompletion:NO];
    [self runAction:playSFX];
    
    self.score++;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    
    if (self.score <= 30)
    {
        player.rate = player.rate * 1.03;
    }
    
    else
    {
        ball.physicsBody.restitution = 1;
    }
    
}

-(void) addPlayer  {
    
    
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];
    
    _center = [SKNode node];
    _center.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self addChild:_center];
    
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddle.physicsBody.dynamic = NO;
    
    [_center addChild:_paddle];
    
    _paddle.position = CGPointMake(0, -self.frame.size.width/2 + 25);
    self.paddle.zRotation = M_PI/2;
    self.paddle.physicsBody.categoryBitMask = downpaddlecategory;
    
    
}

-(void) addPlayer2:(CGSize)size  {
    
    
    self.paddleup = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];
    
    self.paddleup.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleup.physicsBody.dynamic = NO;
    
    [_center addChild:_paddleup];
    
    _paddleup.position = CGPointMake(0, self.frame.size.width/2 - 25);
    self.paddleup.zRotation = -M_PI/2;
    self.paddleup.physicsBody.categoryBitMask = uppaddlecategory;
    
    
    
}

-(void) addPlayer3:(CGSize)size  {
    
    
    self.paddleleft = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];
    
    self.paddleleft.position = CGPointMake(12.5,size.height/2);
    
    self.paddleleft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleleft.physicsBody.dynamic = NO;
    
    self.paddleleft.physicsBody.categoryBitMask = leftpaddlecategory;
    
    
    [self addChild:self.paddleleft];

}

-(void) addPlayer4:(CGSize)size  {
    
    
    self.paddleright = [SKSpriteNode spriteNodeWithImageNamed:@"Paddle"];
    
    self.paddleright.position = CGPointMake(307.5,size.height/2);
    
    self.paddleright.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 100)];
    
    self.paddleright.physicsBody.dynamic = NO;
    self.paddleright.zRotation = M_PI;
    
    self.paddleright.physicsBody.categoryBitMask = rightpaddlecategory;
    
    
    
    [self addChild:self.paddleright];
}

-(void)gameover
{
    
    location = CGPointMake(0, 0);
    isPlaying = false;
    [ball removeFromParent];
    SKSpriteNode *gameover = [SKSpriteNode spriteNodeWithImageNamed:@"Gameover"];
    gameover.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:gameover];
    
    home = [SKSpriteNode spriteNodeWithImageNamed:@"Home"];
    home.position = CGPointMake(self.size.width - self.size.width/3, self.size.height/4);
    [self addChild:home];
    
    retry = [SKSpriteNode spriteNodeWithImageNamed:@"Retry"];
    retry.position = CGPointMake(self.size.width/3, self.size.height/4);
    [self addChild:retry];
    
    [player stop];
    
    if ([GCHelper sharedInstance].gameCenterEnabled)
    {
        [[GCHelper sharedInstance]reportScore:self.score];
    }
    
    int best = [[NSUserDefaults standardUserDefaults] integerForKey:@"best"];
    
    if (_score >= best)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"best"];
        best = _score;
    }
    
    _scoreLabel.position = CGPointMake(self.view.frame.size.width/2,(self.view.frame.size.height/2) + (self.view.frame.size.height/30));
    _scoreLabel.fontSize = 32;
    _scoreLabel.fontColor = [UIColor colorWithRed:1 green:0.941 blue:0.322 alpha:1];
    
    
    /*SKLabelNode *currentScore = [SKLabelNode labelNodeWithFontNamed:@"ArialBlack"];
     currentScore.fontColor = [UIColor colorWithRed:1 green:0.941 blue:0.322 alpha:1];
     currentScore.text = [NSString stringWithFormat:@"%d", _score];
     currentScore.position = CGPointMake(self.view.frame.size.width/2,(self.view.frame.size.height/2) + (self.view.frame.size.height/30));
     [self addChild:currentScore];*/
    
    SKLabelNode *highScore = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    highScore.fontColor = [UIColor colorWithRed:1 green:0.941 blue:0.322 alpha:1];
    highScore.text = [NSString stringWithFormat:@"%d", best];
    highScore.position = CGPointMake(self.view.frame.size.width/2,(self.view.frame.size.height/2) - (self.view.frame.size.height/16));
    [self addChild:highScore];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAd" object:nil];
    
    retryConstraint = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1 alpha:0] size:CGSizeMake(102/2, 102/2)];
    homeConstraint = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1 alpha:0] size:CGSizeMake(102/2, 102/2)];
    
    retryConstraint.position = CGPointMake(self.size.width/3, self.size.height/4);
    homeConstraint.position = CGPointMake(self.size.width - self.size.width/3, self.size.height/4);
}

-(void)update:(CFTimeInterval)currentTime
{
    if (isPlaying)
    {
    
    if ([rightButton containsPoint:location])
    {
    _center.zRotation = _center.zRotation - M_PI/50;
    }
    if ([leftButton containsPoint:location])
    {
        _center.zRotation = _center.zRotation + M_PI/50;

    }
    }
    
    if ([homeConstraint containsPoint:location]&&[homeConstraint containsPoint:endLocation])
    {
        SKScene *scene = [menu sceneWithSize:self.size];
        [self.view presentScene:scene];
    }
    
    if ([retryConstraint containsPoint:location]&&[retryConstraint containsPoint:endLocation])
    {
        SKScene *scene = [CircularScene sceneWithSize:self.size];
        [self.view presentScene:scene];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
    }
}

@end;


