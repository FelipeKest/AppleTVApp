//
//  GameScene.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 24/08/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

protocol GameDelegate {
    func returnToMenu(from scene: SKScene)
}

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: Variables and Constants
    var scroller: InfiniteScrollingBackground?
    static var isInBattle: Bool! = false
    var firstBattleDone: Bool! = false
    var hasTouched: Bool! = false
    static public var gameOver: Bool! = false
    var player = Student.instance
    var playerBeam = HitBeam(body: UIImage(named: "beam_player_blurred")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Player")!, livesOfOwner: 3)
    var alien = Alien(life: 2, imagensAlien: [UIImage(named: "alien1")!, UIImage(named: "alien2")!, UIImage(named: "alien3")!, UIImage(named: "alien4")!])
    var alienBeam = HitBeam(body: UIImage(named: "beam_alien_blurred")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Alien")!, livesOfOwner: 2)
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
    var playerBaseParticle: SKEmitterNode?
    var alienBaseParticle: SKEmitterNode?
    var boom: SKSpriteNode?
    
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
        print("Left: \(leftCard.numberValue)")
        if leftCard.numberValue > rightCard.numberValue {
            // ganha o ponto e da hit no alien
            print("Estudante antes de levar",Student.studentHealth)
            print("Alien antes de levar ",alien.alienHealth)
            leftCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ",Student.studentHealth)
            print("Alien leva hit = ",alien.alienHealth)
            
            let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
            let beamGrow = SKAction.resize(toWidth: CGFloat(beamPiece * Double((Student.studentHealth)+1)), duration: 0.5)
            
            self.playerBeam.run(beamGrow)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.increase(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
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
            
            let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
            let beamShrink = SKAction.resize(toWidth: CGFloat(beamPiece * Double((Student.studentHealth)-1)), duration: 0.5)
            
            self.playerBeam.run(beamShrink)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                })

            }
        }
    
    @objc func swipeRight(){
        print("Left: \(String(describing: leftCard.numberValue))")
        print("Right:\(String(describing: rightCard.numberValue))")
        if rightCard.numberValue > leftCard.numberValue {
            // ganha e da hit no alien
            print("Estudante antes de dar =", Student.studentHealth)
            print("Alien antes de levar =", alien.alienHealth)
            //Attack.increase(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: true)
            rightCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ", Student.studentHealth)
            print("Alien leva hit = ", alien.alienHealth)
            
            let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
            let beamGrow = SKAction.resize(toWidth: CGFloat(beamPiece * Double((Student.studentHealth)+1)), duration: 0.5)
            
            self.playerBeam.run(beamGrow)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.increase(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
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
            
            let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
            let beamShrink = SKAction.resize(toWidth: CGFloat(beamPiece * Double((Student.studentHealth)-1)), duration: 0.5)
            
            self.playerBeam.run(beamShrink)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()
                
                Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &self.alien.alienHealth, ammount: 1)
                })
            
            }
    }
    
    override func didMove(to view: SKView) {
        
        self.view?.isPaused = false
        
        for family in UIFont.familyNames {
            
            let sName: String = family as String
            print("family: \(sName)")
            
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        
        //define quais imagens são utilizadas no background
        let backgroundimages = [UIImage(named: "bg1")!, UIImage(named: "bg2")!]
        
        self.swipeLeftInstance = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeLeft))
        self.swipeLeftInstance?.direction = .left
        self.view?.addGestureRecognizer(swipeLeftInstance!)
        
        self.swipeRightInstance = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeRight))
        self.swipeRightInstance?.direction = .right
        self.view?.addGestureRecognizer(swipeRightInstance!)
        
        // Initializing InfiniteScrollingBackground's Instance:
        scroller = InfiniteScrollingBackground(images: backgroundimages, scene: self, scrollDirection: .left, speed: 5)
        
        // Using it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1
        
        player.zPosition = 3
        player.position = CGPoint(x: -360, y: -150)
        player.texture = SKTexture(image: Student.studentImages[0])
        player.size = CGSize(width: 175.0, height: 250.0)
        self.addChild(player)
        
        playerRun()
        
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
            //alien.removeFromParent()
            playerBeam.removeFromParent()
            leftCardBG?.removeFromParent()
            rightCardBG?.removeFromParent()
            leftCardText?.removeFromParent()
            rightCardText?.removeFromParent()
            alienBaseParticle?.removeFromParent()
            playerBaseParticle?.removeFromParent()
            
            let boom = SKSpriteNode(imageNamed: "boom.png")
            boom.position = alien.position
            boom.zPosition = 50
            boom.size = CGSize(width: 220, height: 150)
            self.addChild(boom)
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                boom.removeFromParent()
            })
            
            let spin = SKAction.rotate(byAngle: 1080, duration: 2)
            let moveOutOfScene = SKAction.moveTo(x: 1200, duration: 2)
            alien.run(spin)
            alien.run(moveOutOfScene)
            
            GameScene.isInBattle = false
            
            //PLAYER muda de animacao
            
            alien.alienHealth = Student.studentHealth - 2
            Student.studentHealth = 3
            scroller?.resumeScroll()
            
            playerRun()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.alien.removeAllActions()
                self.alien.removeFromParent()
            })
            
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { (timer) in
                self.setUpBattle()
            })
         
        }
        if GameScene.gameOver == true {
            self.view?.isPaused = true
            gameDelegate.returnToMenu(from: self)
            scene?.view?.window?.rootViewController?.dismiss(animated: false, completion: nil)
            GameScene.gameOver = false
            Student.studentHealth = 3
        }
    }
    
    
    
    func setUpBattle () {
        self.scroller?.stopScroll()
        
        self.player.removeAllActions()
        
        player.texture = SKTexture(image: Student.studentImages[2])
        
        print("LeftValue: \(String(describing:leftCard.numberValue))")
        print("RightValue: \(String(describing: rightCard.numberValue))")
        
        leftCard.convertNumber(value: leftCard.numberValue)
        rightCard.convertNumber(value: rightCard.numberValue)
        
        alien.zPosition = 3
        alien.zRotation = 0
        alien.position = CGPoint(x: 700, y: -180)
        alien.texture = SKTexture(image: alien.alienImages[Int.random(min: 0, max: alien.alienImages.count-1)])
        alien.size = CGSize(width: 200.0, height: 200.0)
        self.addChild(alien)
        
        let alienAnimation: SKAction
        alienAnimation = SKAction.move(to: CGPoint(x: 300.0, y: alien.position.y), duration: 1)
        alien.run(alienAnimation)
        
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
            
            self.player.texture = SKTexture(image: Student.studentImages[3])

            self.playerBaseParticle = self.playerBeam.beamBodyParticle
            self.playerBaseParticle?.position = CGPoint(x: -290, y: -160)
            self.playerBaseParticle?.zPosition = 7
            self.addChild(self.playerBaseParticle!)
        
            self.alienBaseParticle = self.alienBeam.beamBodyParticle
            self.alienBaseParticle?.position = CGPoint(x: 290, y: -160)
            self.alienBaseParticle?.zPosition = 7
            self.addChild(self.alienBaseParticle!)
            
            let beamAppearing: SKAction
            
            self.playerBeam.zPosition = 6
            self.playerBeam.position = CGPoint(x: -290, y: -160)
            self.playerBeam.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            self.playerBeam.alpha = 0
            
            self.alienBeam.zPosition = 5
            self.alienBeam.position = CGPoint(x: 0, y: -160)
            self.alienBeam.size = CGSize(width: self.distanceBetween, height: 80.0)
            self.alienBeam.alpha = 0
            
            self.addChild(self.alienBeam)
            
            let beamPiece = self.distanceBetween / Double(Student.studentHealth + self.alien.alienHealth)
            self.playerBeam.size = CGSize(width: beamPiece * Double(Student.studentHealth), height: 80.0)
            
            self.addChild(self.playerBeam)
            
            beamAppearing = SKAction.fadeAlpha(to: 1, duration: 1)
            self.playerBeam.run(beamAppearing)
            self.alienBeam.run(beamAppearing)
            
        })
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            
            let zoomIn: SKAction
            zoomIn = SKAction.scale(by: 10, duration: 0.5)
            
            self.leftCardBG = SKSpriteNode(texture: SKTexture(image: self.leftCard.cardBG))
            self.leftCardBG?.zPosition = 15
            self.leftCardBG?.position = CGPoint(x: -150, y: 100)
            self.leftCardBG?.size = CGSize(width: 22, height: 18)
            self.addChild(self.leftCardBG!)
            self.leftCardBG?.run(zoomIn)
            
            self.rightCardBG = SKSpriteNode(texture: SKTexture(image: self.rightCard.cardBG))
            self.rightCardBG?.zPosition = 15
            self.rightCardBG?.position = CGPoint(x: 150, y: 100)
            self.rightCardBG?.size = CGSize(width: 22, height: 18)
            self.addChild(self.rightCardBG!)
            self.rightCardBG?.run(zoomIn)
            
            
        })
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
            
            self.leftCardText = SKLabelNode(text: self.leftCard.numberDisplay)
            self.leftCardText?.zPosition = 20
            self.leftCardText?.fontSize = 50
            self.leftCardText?.fontName = "HanziPenSC-W5"
            self.leftCardText?.fontColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
            self.leftCardText?.position = CGPoint(x: (self.leftCardBG?.position.x)!, y: (self.leftCardBG?.position.y)! - 10)
            self.addChild(self.leftCardText!)
            self.rightCardText = SKLabelNode(text: self.rightCard.numberDisplay)
            self.rightCardText?.zPosition = 20
            self.rightCardText?.fontSize = 50
            self.rightCardText?.fontName = "HanziPenSC-W5"
            self.rightCardText?.fontColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
            self.rightCardText?.position = CGPoint(x: (self.rightCardBG?.position.x)!, y: (self.rightCardBG?.position.y)! - 10)
            self.addChild(self.rightCardText!)
            
        })
        
        cardsNeeded = false
        
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
    
    func playerRun () {
        let runningFrames: [SKTexture] = [SKTexture(image: Student.studentImages[0]), SKTexture(image: Student.studentImages[1])]
        let runningAction = SKAction.animate(with: runningFrames, timePerFrame: 0.2)
        let runningForever = SKAction.repeatForever(runningAction)
        self.player.run(runningForever)
    }
}
