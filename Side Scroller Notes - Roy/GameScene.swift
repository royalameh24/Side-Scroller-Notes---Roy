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
    let cam = SKCameraNode()
    let speedFactor = 1
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //sets orientation of info-p list
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        character = self.childNode(withName: "guy") as? SKSpriteNode
        character.physicsBody?.velocity = CGVector(dx: 0, dy: 0.0)
        
        ground = self.childNode(withName: "ground") as? SKSpriteNode
        
        self.camera = cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = character.position
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var speed = 0.0
        for touch in touches {
            speed = (touch.location(in: self).x - self.childNode(withName: "guy")!.position.x) as! CGFloat
        }
        var yCurrentVector = self.childNode(withName: "guy")?.physicsBody?.velocity.dy
        self.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: speed, dy: yCurrentVector!)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var guy : SKSpriteNode!
        var coin : SKSpriteNode!
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            guy = contact.bodyA.node as? SKSpriteNode
            coin = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1 {
            coin = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        if coin != nil {
            coin.removeFromParent()
        }
    }
}
