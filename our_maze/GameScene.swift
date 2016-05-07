//
//  GameScene.swift
//  our_maze
//
//  Created by Sharol Chand on 5/6/16.
//  Copyright (c) 2016 Sharol Chand. All rights reserved.
//

import SpriteKit
import CoreMotion
import AudioToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /* Setup your scene here */
    let manager = CMMotionManager()
    var message = SKLabelNode()
    var playAgain = SKLabelNode()
    var muffin = SKSpriteNode()
    var gameBackgroundMusic = SKAudioNode()
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        gameBackgroundMusic = SKAudioNode(fileNamed: "dog.mp3")
        addChild(gameBackgroundMusic)
        
        
        /* Manager Stuff */
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            
            self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)!) * 10, CGFloat((data?.acceleration.y)!) * 10)
        }
        
        
        
        //let ball = SKShapeNode(circleOfRadius: 50)
        //let ball = SKSpriteNode(imageNamed: "muffin_medium")
        

        //ball.position = CGPointMake(500, 150)
        //ball.name = "Roundie"

        message = self.childNodeWithName("popUp") as! SKLabelNode
        playAgain = self.childNodeWithName("playAgain") as! SKLabelNode
        muffin = self.childNodeWithName("muffin") as! SKSpriteNode

        playAgain.text = ""
        message.text = ""
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var ballHit: SKPhysicsBody
        var border: SKPhysicsBody
        
        if contact.bodyA.fieldBitMask < contact.bodyB.fieldBitMask{
            ballHit = contact.bodyA
            border = contact.bodyB
        }
        else{
            ballHit = contact.bodyB
            border = contact.bodyA
        }
    
        
        if(ballHit.fieldBitMask == 1 && border.fieldBitMask == 2){
            //ballHit.node?.removeFromParent()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            message.text = "You lost"
            message.fontColor = UIColor()
        }
        
        if(ballHit.fieldBitMask == 1 && border.fieldBitMask == 3){
            //ballHit.node?.removeFromParent()
            message.text = "You WIN"
            
        }
        
        muffin.hidden = true
        playAgain.text = "Touch to Play Again"
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            
            if((self.childNodeWithName("Roundie")) == nil){
                
                playAgain.text = ""
                message.text = ""
                
                
                muffin.position = CGPointMake(904, 250)
                muffin.physicsBody?.velocity.dx = 0
                muffin.physicsBody?.velocity.dy = 0
                muffin.hidden = false

            }
            

        }
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
