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
    
    /// Flapp bird node.
    private var flappyBird = SKSpriteNode()
    
    /// Background node.
    private var background = SKSpriteNode()
    
    // Pipes.
    private var pipeUp = SKSpriteNode()
    private var pipeDown = SKSpriteNode()

    //----------------------------------
    // MARK: - View life cycle
    //----------------------------------
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        setupBackgroundNode()
        setupFlappyBirdNode()
        setupGroundNode()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("setupPipes"), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // Apply impulse.
        if let physicsBody = self.flappyBird.physicsBody {
            physicsBody.velocity = CGVectorMake(0.0, 0.0)
            physicsBody.applyImpulse(CGVectorMake(0.0, 75.0))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //----------------------------------
    // MARK: - Sprite nodes
    //----------------------------------
    
    private func setupBackgroundNode() {
        // Create background texture.
        let backgroundTexture = SKTexture(imageNamed: "bg.png")
        
        // Create forever move background action.
        let moveBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0.0, duration: 9.0)
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y: 0.0, duration: 0.0)
        let moveBackgroundForever = SKAction.repeatActionForever(SKAction.sequence([moveBackground, replaceBackground]))
        
        for var i: CGFloat = 0; i < 3; ++i {
            self.background = SKSpriteNode(texture: backgroundTexture)
            
            self.background.position = CGPoint(x: backgroundTexture.size().width / 2.0 + backgroundTexture.size().width * i, y: CGRectGetMidY(self.frame))
            self.background.size.height = CGRectGetHeight(self.frame)
            self.background.runAction(moveBackgroundForever)
            
            self.addChild(background)
        }
    }
    
    private func setupFlappyBirdNode() {
        // Create bird textures.
        let birdTextureWingsUp   = SKTexture(imageNamed: "flappy1.png")
        let birdTextureWingsDown = SKTexture(imageNamed: "flappy2.png")
        
        // Create forever flapp animation.
        let animation = SKAction.animateWithTextures([birdTextureWingsUp, birdTextureWingsDown], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        // Setup flappy bird node.
        self.flappyBird = SKSpriteNode(texture: birdTextureWingsUp)
        self.flappyBird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.flappyBird.runAction(makeBirdFlap)
        
        // Create physic body and apply gravity to it.
        self.flappyBird.physicsBody = SKPhysicsBody(circleOfRadius: birdTextureWingsUp.size().height / 2.0)
        self.flappyBird.physicsBody!.dynamic = true
        
        self.addChild(flappyBird)
    }
    
    private func setupGroundNode() {
        let groundNode = SKNode()
        groundNode.position = CGPointMake(0.0, 0.0)
        groundNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1.0))
        groundNode.physicsBody!.dynamic = false
        
        self.addChild(groundNode)
    }
    
    func setupPipes() {
        // Textures.
        let pipeUpTexture = SKTexture(imageNamed: "pipe1.png")
        let pipeDownTexture = SKTexture(imageNamed: "pipe2.png")
        
        // Position the pipes.
        let gapHeight = self.flappyBird.size.height * 4.0
        let movementAmount = CGFloat(arc4random()) % self.frame.size.height / 2.0
        let pipeOffset = movementAmount - self.frame.size.height / 4.0
        
        // Actions.
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2.0, y: 0.0, duration: NSTimeInterval(self.frame.size.width / 100.0))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        // Up.
        self.pipeUp = SKSpriteNode(texture: pipeUpTexture)
        self.pipeUp.position = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame) + pipeUpTexture.size().height / 2.0 + gapHeight / 2.0 + pipeOffset)
        self.pipeUp.runAction(moveAndRemovePipes)
        
        self.addChild(pipeUp)
        
        // Down.
        self.pipeDown = SKSpriteNode(texture: pipeDownTexture)
        self.pipeDown.position = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame) - pipeDownTexture.size().height / 2.0 - gapHeight / 2.0 + pipeOffset)
        self.pipeDown.runAction(moveAndRemovePipes)
        
        self.addChild(pipeDown)
    }
}
