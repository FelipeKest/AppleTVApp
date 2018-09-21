//
//  GameScene.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 24/08/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameDelegate {
    func returnToMenu(from scene: SKScene)
    func presentGameOverView(from scene: SKScene)
}

class GameScene: SKScene {
    
    // MARK: Variables and Constants
    var scroller: InfiniteScrollingBackground?
    static var isInBattle: Bool! = false
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
    
    var gameDelegate: GameDelegate!
    
    init(battleState: Bool) {
        super.init()
        GameScene.isInBattle = battleState
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Swipe Functions
    
    @objc func swipeLeft(){
        if leftCard.numberValue > rightCard.numberValue {
            // ganha o ponto e da hit no alien
            print("Estudante antes de levar",self.player.studentHealth)
            print("Alien antes de levar ",alien.alienHealth)
    
            leftCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ",self.player.studentHealth)
            print("Alien leva hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.increase(alunoLife: &self.player.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(self.player.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(self.player.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x + beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
        }
        else {
            print(self.player.studentHealth)
            print(alien.alienHealth)
            //Attack.decrease(alunoLife: &self.player.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //leftCard.changeBG(correct: false)
            leftCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ",self.player.studentHealth)
            print("Alien da hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()

                Attack.decrease(alunoLife: &self.player.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(self.player.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(self.player.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x - beamPieceStep.x/2, y: self.alienBeam.position.y)
                
            })
        }
    }
    
    @objc func swipeRight(){
        if rightCard.numberValue > leftCard.numberValue {
            // ganha e da hit no alien
            print("Estudante antes de dar =", self.player.studentHealth)
            print("Alien antes de levar =", alien.alienHealth)
            //Attack.increase(alunoLife: &self.player.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: true)
            rightCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ", self.player.studentHealth)
            print("Alien leva hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                Attack.increase(alunoLife: &self.player.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(self.player.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(self.player.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x + beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
        }
        else {
            print(self.player.studentHealth)
            print(alien.alienHealth)
            //Attack.decrease(alunoLife: &self.player.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: false)
            rightCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ", self.player.studentHealth)
            print("Alien da hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                Attack.decrease(alunoLife: &self.player.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                let beamPiece = self.distanceBetween / Double(self.player.studentHealth + self.alien.alienHealth)
                self.playerBeam.size = CGSize(width: beamPiece * Double(self.player.studentHealth), height: 80.0)
                self.alienBeam.size = CGSize(width: beamPiece * Double(self.alien.alienHealth), height: 80.0)
                let beamPieceStep = CGPoint(x: beamPiece, y: 0)
                self.alienBeam.position = CGPoint(x: self.alienBeam.position.x - beamPieceStep.x/2, y: self.alienBeam.position.y)
            })
            
        }
    }
    
    
    //MARK: Overrides
    override func didMove(to view: SKView) {
        self.view?.isPaused = false
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
        
        self.player.zPosition = 3
        self.player.position = CGPoint(x: -360, y: -150)
        self.player.texture = SKTexture(image: self.player.studentImages[0])
        self.player.size = CGSize(width: 175.0, height: 250.0)
        self.addChild(self.player)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
            self.scroller?.stopScroll()

            if self.cardsNeeded == true{
                self.setUpBattle()
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
            
            //self.player muda de animacao
            
            alien.alienHealth = self.player.studentHealth - 2
            self.player.studentHealth = 3
            scroller?.resumeScroll()
            
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { (timer) in
                self.setUpBattle()
            })
         
        }
        if self.player.studentHealth == 0 {
            GameScene.isInBattle = false
            GameScene.gameOver = true
    
        }
        
        if GameScene.gameOver == true {
            //Chamar uma view
            self.view?.isPaused = true
            gameDelegate.presentGameOverView(from: self)
            self.player.studentHealth = 3
            
        }
    }
    
    
    //MARK: Battle Setup and CardChanges
    func setUpBattle () {
        self.scroller?.stopScroll()
        
        print("LeftValue: \(String(describing:leftCard.numberValue))")
        print("RightValue: \(String(describing: rightCard.numberValue))")
        
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
        
        playerBeam.zPosition = 5
        playerBeam.position = CGPoint(x: -290, y: -160)
        playerBeam.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        let beamPiece = distanceBetween / Double(playerBeam.numOfLives + alienBeam.numOfLives)
        playerBeam.size = CGSize(width: beamPiece * Double(playerBeam.numOfLives), height: 80.0)
        
        self.addChild(playerBeam)
        
        
        alienBeam.zPosition = 5
        alienBeam.position = CGPoint(x: 180, y: -160)
        alienBeam.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        alienBeam.size = CGSize(width: beamPiece * Double(alienBeam.numOfLives), height: 80.0)
        
        self.addChild(alienBeam)
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

