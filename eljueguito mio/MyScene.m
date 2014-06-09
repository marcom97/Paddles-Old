//
//  MyScene.m
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "MyScene.h"
#import "GameOver.h"

@interface MyScene ()

@property (nonatomic) SKSpriteNode *paddle;
@property (nonatomic) SKSpriteNode *paddleup;
@property (nonatomic) SKSpriteNode *paddleleft;
@property (nonatomic) SKSpriteNode *paddleright;
@property (nonatomic)  SKLabelNode* scoreLabel;

@end

static const uint32_t ballcategory = 1;
static const uint32_t paddlecategory = 2;
static const uint32_t bordercategory = 4;


@implementation MyScene

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
        [self addPlayer4:size];
        [self addPlayer3:size];
        [self addscore:size];
        
        start = true;
        isPlaying = true;
        
        self.score = 0;

    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (start == true)
    {
        [ball.physicsBody applyImpulse:CGVectorMake(4, 4)];
        start = false;

    }

}


-(void) addscore:(CGSize)size{
    
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy-Bold"];
    _scoreLabel.fontSize = 35;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    _scoreLabel.fontColor = [SKColor whiteColor];
    _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_scoreLabel];
    
}



-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    
    
    
    if (contact.bodyA.categoryBitMask == paddlecategory) {
        SKAction *playSFX = [SKAction playSoundFileNamed:@"bounce 2.caf" waitForCompletion:NO];
        [self runAction:playSFX];
        
        NSString *sparkPath =
        [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
        
        SKEmitterNode *burstEmitter =
        [NSKeyedUnarchiver unarchiveObjectWithFile:sparkPath];
        
        burstEmitter.position = CGPointMake(ball.position.x, ball.position.y);
        
        [self addChild:burstEmitter];
    }
    
    if (contact.bodyB.categoryBitMask == paddlecategory) {
        SKAction *playSFX = [SKAction playSoundFileNamed:@"bounce 2.caf" waitForCompletion:NO];
        [self runAction:playSFX];
    }
    
    if (contact.bodyA.categoryBitMask == paddlecategory) {
       self.score++;
        _scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
        
        
    }
    
    if (contact.bodyB.categoryBitMask == paddlecategory) {
        self.score++;
        _scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
        
    }
    
    
    
    
    if (contact.bodyA.categoryBitMask == bordercategory) {
        [self gameover];
        /*GameOver *end = [[GameOver alloc]  initWithSize:self.size score:self.score];
        [self.view presentScene:end transition:[SKTransition doorwayWithDuration:1.0]];*/
    }
    if (contact.bodyB.categoryBitMask == bordercategory) {
        [self gameover];
        /*GameOver *end = [[GameOver alloc]  initWithSize:self.size score:self.score];
        [self.view presentScene:end transition:[SKTransition fadeWithDuration:1.0]];*/
    }
    
}

- (void) addBall {
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    
    
    ball.position = CGPointMake(self.size.width/2,self.size.height/2);;
    
    
    
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:27/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.categoryBitMask = ballcategory ;
    ball.physicsBody.contactTestBitMask = paddlecategory | bordercategory;
    
    
    [self addChild:ball];
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isPlaying == true)
    {
        
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 12.5);
        
        
        if (newPosition.x < self.paddle.size.width/2-50) {
            newPosition.x = self.paddle.size.width/2-50;
            
        }
        if (newPosition.x > self.size.width - self.paddle.size.width/2+50) {
            newPosition.x = self.size.width - self.paddle.size.width/2+50;
            
        }
        
        self.paddle.position= newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, self.size.height-12.5);
        
        
        
        if (newPosition.x < self.paddle.size.width/2-50) {
            newPosition.x = self.paddle.size.width/2-50;
            
        }
        if (newPosition.x > self.size.width - self.paddle.size.width/2+50) {
            newPosition.x = self.size.width - self.paddle.size.width/2+50;
            
        }
        
        self.paddleup.position =newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(13, location.y);
        
        
        if (newPosition.y < self.paddle.size.width/2-50) {
            newPosition.y = self.paddle.size.width/2-50;
            
        }
        if (newPosition.y > self.size.height - self.paddle.size.width/2+50) {
            newPosition.y = self.size.height - self.paddle.size.width/2+50;
            
        }
        
        self.paddleleft.position =newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(307, location.y);
        
        if (newPosition.y < self.paddle.size.width/2-50) {
            newPosition.y = self.paddle.size.width/2-50;
            
        }
        if (newPosition.y > self.size.height - self.paddle.size.width/2+50) {
            newPosition.y = self.size.height - self.paddle.size.width/2+50;
            
        }
        
        self.paddleright.position =newPosition;
    }
    }
    
}



-(void) addPlayer  {
    
    
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    
    self.paddle.position = CGPointMake(self.size.width/2,12.5);
    
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 25)];
    
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddlecategory;
    
    
    [self addChild:self.paddle];
}

-(void) addPlayer2:(CGSize)size  {
    
    
    self.paddleup = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    
    self.paddleup.position = CGPointMake(size.width/2,self.size.height-12.5);
    
    self.paddleup.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 25)];
    
    self.paddleup.physicsBody.dynamic = NO;
    self.paddleup.zRotation = M_PI;
    self.paddleup.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleup];
}

-(void) addPlayer3:(CGSize)size  {
    
    
    self.paddleleft = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    
    self.paddleleft.position = CGPointMake(12.5,size.height/2);
    
    self.paddleleft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 25)];
    
    self.paddleleft.physicsBody.dynamic = NO;
    self.paddleleft.zRotation = -M_PI/2;

    self.paddleleft.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleleft];
}

-(void) addPlayer4:(CGSize)size  {
    
    
    self.paddleright = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    
    self.paddleright.position = CGPointMake(307.5,size.height/2);

    
    self.paddleright.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 25)];

    self.paddleright.physicsBody.dynamic = NO;
    self.paddleright.zRotation = M_PI/2;

    self.paddleright.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleright];
}

-(void)gameover
{
    isPlaying = false;
    [ball removeFromParent];
    SKSpriteNode *gameover = [SKSpriteNode spriteNodeWithImageNamed:@"Gameover"];
    gameover.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:gameover];
}

-(void)update:(CFTimeInterval)currentTime {
    
}


@end;

