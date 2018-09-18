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
    static var isInBattle: Bool! = false
    var firstBattleDone: Bool! = false
    var hasTouched: Bool! = false
    static public var gameOver: Bool! = false
    var player = Student.instance
    var playerBeam = HitBeam(body: UIImage(named: "beam_player")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Player")!, livesOfOwner: 3)
    var alien = Alien(life: 2, imagensAlien: [UIImage(named: "Alien1")!])
    var alienBeam = HitBeam(body: UIImage(named: "beam_alien")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Alien")!, livesOfOwner: 2)
    var swipeLeftInstance: UISwipeGestureRecognizer?
    var swipeRightInstance: UISwipeGestureRecognizer?
    var distanceBetween: Double = 580
    public var leftCard = NumberCard(cardBG: UIImage(named: "card_neutro")!, numberValue: Float.random(min:0.01, max: 2.99))
    public var rightCard = NumberCard(cardBG: UIImage(named: "card_neutro")!, numberValue: Float.random(min:0.01, max: 2.99))
    var cardsNeeded: Bool! = true
    public var leftCardBG: SKSpriteNode?
    public var rightCardBG: SKSpriteNode?
    public var leftCardText: SKLabelNode?
    public var rightCardText: SKLabelNode?
    
    init(battleState: Bool) {
        super.init()
        GameScene.isInBattle = battleState
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func swipeLeft(){
        print("Left: \(leftCard.numberValue)")
        if leftCard.numberValue > rightCard.numberValue {
            // ganha o ponto e da hit no alien
            print("Estudante antes de levar",Student.studentHealth)
            print("Alien antes de levar ",alien.alienHealth)
            //Attack.increase(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //leftCard.changeBG(correct: true)
            leftCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ",Student.studentHealth)
            print("Alien leva hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.increase(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x + beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
            

        }
        else {
            print(Student.studentHealth)
            print(alien.alienHealth)
            //Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //leftCard.changeBG(correct: false)
            leftCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ",Student.studentHealth)
            print("Alien da hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x - beamPieceStep.x/2, y: self.alienBeam.position.y)
            })

        }
    }
    
    @objc func swipeRight(){
        print("Left: \(leftCard.numberValue)")
        print("Right:")
        if rightCard.numberValue > leftCard.numberValue {
            // ganha e da hit no alien
            print("Estudante antes de dar =", Student.studentHealth)
            print("Alien antes de levar =", alien.alienHealth)
            //Attack.increase(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: true)
            rightCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ", Student.studentHealth)
            print("Alien leva hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                Attack.increase(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x + beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
            
        }
        else {
            print(Student.studentHealth)
            print(alien.alienHealth)
            //Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: false)
            rightCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ", Student.studentHealth)
            print("Alien da hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x - beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
            
        }
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
        
        player.zPosition = 3
        player.position = CGPoint(x: -360, y: -150)
        player.texture = SKTexture(image: player.studentImages[0])
        player.size = CGSize(width: 175.0, height: 250.0)
        self.addChild(player)
        
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { (timer) in
            self.scroller?.stopScroll()

            if self.cardsNeeded == true{
                self.setUpBattle()
                self.firstBattleDone = true
            }
        })

    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
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
        
        
        if alien.alienHealth == 0 {
            // passa de fase
            alienBeam.removeFromParent()
            alien.removeFromParent()
            playerBeam.removeFromParent()
            leftCardBG?.removeFromParent()
            rightCardBG?.removeFromParent()
            leftCardText?.removeFromParent()
            rightCardText?.removeFromParent()
            GameScene.isInBattle = false
            
            //PLAYER muda de animacao
            
            alien.alienHealth = Student.studentHealth - 2
            Student.studentHealth = 3
            scroller?.resumeScroll()
            
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { (timer) in
                self.setUpBattle()
            })
         
        }
        if Student.studentHealth == 0 {
            // game over
            GameScene.isInBattle = false
            GameScene.gameOver = true
        }
    }
    
    
    
    func setUpBattle () {
        self.scroller?.stopScroll()
        
        print("LeftValue: \(leftCard.numberValue)")
        print("RightValue: \(rightCard.numberValue)")
        
        leftCard.convertNumber(value: leftCard.numberValue)
        rightCard.convertNumber(value: rightCard.numberValue)
        
        
        leftCardBG = SKSpriteNode(texture: SKTexture(image: leftCard.cardBG))
        leftCardBG?.zPosition = 15
        leftCardBG?.position = CGPoint(x: -150, y: 100)
        leftCardBG?.size = CGSize(width: 220, height: 180)
        
        self.addChild(leftCardBG!)
        
        rightCardBG = SKSpriteNode(texture: SKTexture(image: rightCard.cardBG))

        rightCardBG?.zPosition = 15
        rightCardBG?.position = CGPoint(x: 150, y: 100)
        rightCardBG?.size = CGSize(width: 220, height: 180)
        
        self.addChild(rightCardBG!)
        
        leftCardText = SKLabelNode(text: leftCard.numberDisplay)
        
        leftCardText?.zPosition = 20
        //leftCardText?.fontName = "HanziPen"
        leftCardText?.fontColor = UIColor.black
        leftCardText?.position = (leftCardBG?.position)!
        
        self.addChild(leftCardText!)
        
        rightCardText = SKLabelNode(text: rightCard.numberDisplay)
        
        rightCardText?.zPosition = 20
        //rightCardText?.fontName = "HanziPen"
        rightCardText?.fontColor = UIColor.black
        rightCardText?.position = (rightCardBG?.position)!
        
        self.addChild(rightCardText!)
        cardsNeeded = false
            
        alien.zPosition = 3
        alien.position = CGPoint(x: 300, y: -180)
        alien.texture = SKTexture(image: alien.alienImages[0])
        alien.size = CGSize(width: 200.0, height: 200.0)
        self.addChild(alien)
        
        let beamPiece = distanceBetween / Double(Student.studentHealth + alien.alienHealth)
        let beamPieceStep = CGPoint(x: beamPiece, y: 0)
        
        playerBeam.zPosition = 5
        playerBeam.position = CGPoint(x: -290, y: -160)
        playerBeam.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
        
        self.addChild(playerBeam)
        
        
        alienBeam.zPosition = 5
        alienBeam.position = CGPoint(x: 180, y: -160)
        
        alienBeam.size = CGSize(width: beamPiece * Double(alien.alienHealth), height: 80.0)
        if firstBattleDone == true {
        alienBeam.position = CGPoint(x: self.alienBeam.position.x - beamPieceStep.x/2, y: self.alienBeam.position.y)
        }
        
        self.addChild(alienBeam)
        //isInBattle = false
        
        //hasTouched = true
        //}
    }
    
    
    
    func changeCardValue () {
        leftCard.numberValue = Float.random(min:0.01, max: 2.99)
        rightCard.numberValue = Float.random(min:0.01, max: 2.99)
        leftCard.convertNumber(value: leftCard.numberValue)
        rightCard.convertNumber(value: rightCard.numberValue)
        
        leftCardBG?.texture = SKTexture(imageNamed: "card_neutro")
        rightCardBG?.texture = SKTexture(imageNamed: "card_neutro")
        
        leftCardText?.text = leftCard.numberDisplay
        rightCardText?.text = rightCard.numberDisplay
        
        
    }
}
