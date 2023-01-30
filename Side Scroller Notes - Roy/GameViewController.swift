//
//  GameViewController.swift
//  Side Scroller Notes - Roy
//
//  Created by ROY ALAMEH on 1/30/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var play : GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                play = scene as? GameScene
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscapeLeft
    }

    @IBAction func jumpAction(_ sender: UIButton) {
        play.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: play.childNode(withName: "guy")?.physicsBody?.velocity.dx ?? 30, dy: 500)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
