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
    var isInBattle: Bool! = false
    var hasTouched: Bool! = false
    var player = Student.instance
    var playerBeam = HitBeam(body: UIImage(named: "beam_player")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Player")!, livesOfOwner: 3)
    var alien = Alien(life: 2, imagensAlien: [UIImage(named: "Alien1")!])
    var alienBeam = HitBeam(body: UIImage(named: "beam_alien")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Alien")!, livesOfOwner: 2)
    var swipeLeftInstance: UISwipeGestureRecognizer?
    var swipeRightInstance: UISwipeGestureRecognizer?
    var distanceBetween: Double? = HitBeam.beamSize * 2
    
    
    
    
    init(battleState: Bool) {
        super.init()
        self.isInBattle = battleState
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func swipeLeft(){
        print("Left!!!!!")
    }
    
    @objc func swipeRight(){
        print("Right!!!!!")
    }
    
    
    override func didMove(to view: SKView) {
        //define quais imagens são utilizadas no background
        let backgroundimages = [UIImage(named: "bg1")!, UIImage(named: "bg2")!]
        
        self.swipeLeftInstance = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeLeft))
        self.swipeLeftInstance?.direction = .left
        self.view?.addGestureRecognizer(swipeLeftInstance!)
        
        self.swipeRightInstance = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeRight))
        self.swipeRightInstance?.direction = .right
        self.view?.addGestureRecognizer(swipeRightInstance!)
        
        
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
        if isInBattle && hasTouched == true {
            Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
        }
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
        var beamPortion = distanceBetween!/(alien.alienHealth + Student.studentHealth)
        
        // Called before each frame is rendered
        if isInBattle == true && hasTouched == false{
            player.zPosition = 3
            player.position = CGPoint(x: -320, y: -50)
            player.texture = SKTexture(image: player.studentImages[0])
            player.size = CGSize(width: 100.0, height: 200.0)
            self.addChild(player)

            alien.zPosition = 3
            alien.position = CGPoint(x: 359, y: -70.876)
            alien.texture = SKTexture(image: alien.alienImages[0])
            alien.size = CGSize(width: 100.0, height: 100.0)
            self.addChild(alien)
            

            playerBeam.zPosition = 2
            playerBeam.position = CGPoint(x: -91.029, y: -70.876)
            playerBeam.size = CGSize(width: beamPortion*Student.studentHealth, height: 80.0)
            self.addChild(playerBeam)

            alienBeam.zPosition = 2
            alienBeam.position = CGPoint(x: 190.843, y: -67.876)
            alienBeam.size = CGSize(width: beamPortion*alien.alienHealth, height: 79.0)
            self.addChild(alienBeam)
            
            hasTouched = true
        }
            
        if isInBattle && hasTouched == true {
            
        }
        
        
    }
    

}
