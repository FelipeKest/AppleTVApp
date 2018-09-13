//
//  GameScene.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 24/08/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    var scroller: InfiniteScrollingBackground?
    var isInBattle: Bool!
    var player = Student.instance
    var playerBeam = HitBeam(body: UIImage(named: "beam_player")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Player")!, size: 3.0)
    var alienBeam = HitBeam(body: UIImage(named: "beam_alien")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Alien")!, size: 3.0)
    
    init(battleState: Bool) {
        super.init()
        self.isInBattle = battleState
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        player.position = CGPoint(x: -100, y: -80)
        self.addChild(player)
        playerBeam.zPosition = 3
        playerBeam.position = CGPoint(x: -150, y: -80)
        playerBeam.size = CGSize(width: Student.studentHealth, height: 80.0)
        alienBeam.zPosition = 3
        alienBeam.position = CGPoint(x: 150, y: -81)
        alienBeam.size = CGSize(width: Alien.alienHealth, height: 79.0)
        self.addChild(playerBeam)
        self.addChild(alienBeam)
        
        //define quais imagens são utilizadas no background
        let backgroundimages = [UIImage(named: "bg1")!, UIImage(named: "bg2")!]
        
        // Initializing InfiniteScrollingBackground's Instance:
        scroller = InfiniteScrollingBackground(images: backgroundimages, scene: self, scrollDirection: .left, speed: 10)
        
        // Using it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        scroller?.stopScroll()
        isInBattle = true
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
