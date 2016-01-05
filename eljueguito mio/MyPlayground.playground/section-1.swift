// Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let screen = UIScreen.mainScreen().bounds

let view = SKView(frame: screen)
XCPShowView("Live View", view)

let scene:SKScene = SKScene(size: screen.size)
scene.scaleMode = SKSceneScaleMode.AspectFit
view.presentScene(scene)

let gameover = SKSpriteNode(imageNamed: "Gameover@2x.png")
gameover.position = CGPointMake(screen.size.width/2, screen.size.height/2)
scene.addChild(gameover)


/*home = [SKSpriteNode spriteNodeWithImageNamed:@"Home"];
home.position = CGPointMake(self.size.width - self.size.width/3, self.size.height/4);
[self addChild:home];

retry = [SKSpriteNode spriteNodeWithImageNamed:@"Retry"];
retry.position = CGPointMake(self.size.width/3, self.size.height/4);
[self addChild:retry];*/
