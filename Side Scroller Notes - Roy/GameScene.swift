//
//  GameScene.swift
//  Side Scroller Notes - Roy
//
//  Created by ROY ALAMEH on 1/30/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    private var character : SKSpriteNode!
    private var ground : SKSpriteNode!
    private var score : SKLabelNode!
    let cam = SKCameraNode()
    let speedFactor = 1
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //sets orientation of info-p list
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        character = self.childNode(withName: "guy") as? SKSpriteNode
        character.physicsBody?.velocity = CGVector(dx: 0, dy: 0.0)
        character.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
        
        score = self.childNode(withName: "score") as! SKLabelNode
        
        self.camera = cam
        ground = self.childNode(withName: "ground") as? SKSpriteNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = character.position
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*var speed = 0.0
        for touch in touches {
            speed = (touch.location(in: self).x - self.childNode(withName: "guy")!.position.x) as! CGFloat
        }
        var yCurrentVector = self.childNode(withName: "guy")?.physicsBody?.velocity.dy
        self.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: speed, dy: yCurrentVector!)) */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: self.childNode(withName: "guy")?.physicsBody?.velocity.dx ?? 30, dy: 500)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var guy : SKSpriteNode!
        var coin : SKSpriteNode!
        var block : SKSpriteNode!
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            guy = contact.bodyA.node as? SKSpriteNode
            coin = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1 {
            coin = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1 {
            block = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3 {
            guy = contact.bodyA.node as? SKSpriteNode
            block = contact.bodyB.node as? SKSpriteNode
        }
        
        if coin != nil {
            coin.removeFromParent()
        }
        if block != nil {
            guy.removeFromParent()
        }
    }
    
    
}
