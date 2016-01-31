//
//  GameScene.swift
//  FlappyBird
//
//  Created by Иван Магда on 31.01.16.
//  Copyright (c) 2016 Ivan Magda. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //----------------------------------
    // MARK: - Properties
    //----------------------------------
    
    var flappyBird = SKSpriteNode()

    //----------------------------------
    // MARK: - View life cycle
    //----------------------------------
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Create bird textures.
        let birdTextureWingsUp   = SKTexture(imageNamed: "flappy1.png")
        let birdTextureWingsDown = SKTexture(imageNamed: "flappy2.png")
        
        // Create forever flapp animation.
        let animation = SKAction.animateWithTextures([birdTextureWingsUp, birdTextureWingsDown], timePerFrame: 0.15)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        // Setup flappy bird node.
        self.flappyBird = SKSpriteNode(texture: birdTextureWingsUp)
        self.flappyBird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.flappyBird.runAction(makeBirdFlap)
        
        self.addChild(self.flappyBird)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
