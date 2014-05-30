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
@property SKLabelNode* scoreLabel;

@end

static const uint32_t ballcategory = 1;
static const uint32_t paddlecategory = 2;
static const uint32_t bordercategory = 4;


@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Untitled-4"]];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = bordercategory ;
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self ;
        
        [self addBall: size];
        [self addPlayer];
        [self addPlayer2:size];
        [self addPlayer4:size];
        [self addPlayer3:size];
        [self addscore:size];
        
        
    }
    
    return self;
}


int score1 = 0;

-(void) addscore:(CGSize)size{
    
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Noteworthy-Bold"];
    _scoreLabel.fontSize = 35;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",score1];
    _scoreLabel.fontColor = [SKColor whiteColor];
    _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_scoreLabel];
    
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
        score1++;
        _scoreLabel.text = [NSString stringWithFormat:@"%d",score1];
        
        
    }
    
    if (contact.bodyB.categoryBitMask == paddlecategory) {
        score1++;
        _scoreLabel.text = [NSString stringWithFormat:@"%d",score1];
        
    }
    
    
    
    
    if (contact.bodyA.categoryBitMask == bordercategory) {
        GameOver *end = [GameOver sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition doorwayWithDuration:1.0]];
        score1=0;
    }
    if (contact.bodyB.categoryBitMask == bordercategory) {
        GameOver *end = [GameOver sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition fadeWithDuration:1.0]];
        score1 =0;
    }
    
}

- (void) addBall:(CGSize)size {
    
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    
    
    ball.position = CGPointMake(self.size.width/2,self.size.height/2);;
    
    
    
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.categoryBitMask = ballcategory ;
    ball.physicsBody.contactTestBitMask = paddlecategory | bordercategory;
    
    
    [self addChild:ball];
    
    CGVector myVector = CGVectorMake(4,4);
    [ball.physicsBody applyImpulse:myVector];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 13);
        
        
        if (newPosition.x < self.paddle.size.width / 2) {
            newPosition.x = self.paddle.size.width / 2;
            
        }
        if (newPosition.x > self.size.width - (self.paddle.size.width/2)) {
            newPosition.x = self.size.width - (self.paddle.size.width/2);
            
        }
        
        self.paddle.position= newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, 467);
        
        
        
        if (newPosition.x < self.paddleup.size.width / 2) {
            newPosition.x = self.paddleup.size.width / 2;
            
        }
        if (newPosition.x > self.size.width - (self.paddleup.size.width/2)) {
            newPosition.x = self.size.width - (self.paddleup.size.width/2);
            
        }
        
        self.paddleup.position =newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(13, location.y);
        
        
        if (newPosition.y < self.paddleleft.size.height / 2) {
            newPosition.y = self.paddleleft.size.height / 2;
            
        }
        if (newPosition.y > self.size.height - (self.paddleleft.size.height/2)) {
            newPosition.y = self.size.height - (self.paddleleft.size.height/2);
            
        }
        
        self.paddleleft.position =newPosition;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(307, location.y);
        
        if (newPosition.y < self.paddleright.size.height / 2) {
            newPosition.y = self.paddleright.size.height / 2;
            
        }
        if (newPosition.y > self.size.height - (self.paddleright.size.height/2)) {
            newPosition.y = self.size.height - (self.paddleright.size.height/2);
            
        }
        
        self.paddleright.position =newPosition;
    }
    
}



-(void) addPlayer  {
    
    
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    
    self.paddle.position = CGPointMake(self.size.width/2,13);
    
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddlecategory;
    
    
    [self addChild:self.paddle];
}

-(void) addPlayer2:(CGSize)size  {
    
    
    self.paddleup = [SKSpriteNode spriteNodeWithImageNamed:@"paddleup"];
    
    self.paddleup.position = CGPointMake(size.width/2,self.size.height-(_paddleup.size.height/2));
    
    self.paddleup.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddleup.frame.size];
    
    self.paddleup.physicsBody.dynamic = NO;
    self.paddleup.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleup];
}

-(void) addPlayer3:(CGSize)size  {
    
    
    self.paddleleft = [SKSpriteNode spriteNodeWithImageNamed:@"paddleleft"];
    
    self.paddleleft.position = CGPointMake(13,size.height/2);
    
    self.paddleleft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddleleft.frame.size];
    
    self.paddleleft.physicsBody.dynamic = NO;
    self.paddleleft.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleleft];
}

-(void) addPlayer4:(CGSize)size  {
    
    
    self.paddleright = [SKSpriteNode spriteNodeWithImageNamed:@"paddleright"];
    
    self.paddleright.position = CGPointMake(307,size.height/2);
    
    self.paddleright.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddleright.frame.size];
    
    self.paddleright.physicsBody.dynamic = NO;
    self.paddleright.physicsBody.categoryBitMask = paddlecategory;
    
    
    
    [self addChild:self.paddleright];
}



-(void)update:(CFTimeInterval)currentTime {
    
}


@end;

