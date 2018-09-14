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
    static public var gameOver: Bool! = false
    var player = Student.instance
    var playerBeam = HitBeam(body: UIImage(named: "beam_player")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Player")!, livesOfOwner: 3)
    var alien = Alien(life: 2, imagensAlien: [UIImage(named: "Alien1")!])
    var alienBeam = HitBeam(body: UIImage(named: "beam_alien")!, bodyParticle: SKEmitterNode(fileNamed: "BeamBaseParticle_Alien")!, livesOfOwner: 2)
    var swipeLeftInstance: UISwipeGestureRecognizer?
    var swipeRightInstance: UISwipeGestureRecognizer?
    var distanceBetween: Double = 500
    public var leftCard = NumberCard(cardBG: UIImage(named: "card_neutro")!, numberValue: Float.random(min:0.01, max: 2.99))
    public var rightCard = NumberCard(cardBG: UIImage(named: "card_neutro")!, numberValue: Float.random(min:0.01, max: 2.99))
    var cardsNeeded: Bool! = false
    public var leftCardBG: SKSpriteNode?
    public var rightCardBG: SKSpriteNode?
    public var leftCardText: SKLabelNode?
    public var rightCardText: SKLabelNode?
    
    init(battleState: Bool) {
        super.init()
        self.isInBattle = battleState
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
            Attack.increase(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //leftCard.changeBG(correct: true)
            leftCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ",Student.studentHealth)
            print("Alien leva hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()})
            

        }
        else {
            print(Student.studentHealth)
            print(alien.alienHealth)
            Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //leftCard.changeBG(correct: false)
            leftCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ",Student.studentHealth)
            print("Alien da hit = ",alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()})
        }
    }
    
    @objc func swipeRight(){
        print("Left: \(leftCard.numberValue)")
        print("Right:")
        if rightCard.numberValue > leftCard.numberValue {
            // ganha e da hit no alien
            print("Estudante antes de dar =", Student.studentHealth)
            print("Alien antes de levar =", alien.alienHealth)
            Attack.increase(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            //rightCard.changeBG(correct: true)
            rightCardBG?.texture = SKTexture(imageNamed: "card_correto")
            print("Estudante da hit = ", Student.studentHealth)
            print("Alien leva hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()})
        }
        else {
            print(Student.studentHealth)
            print(alien.alienHealth)
            Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)
            rightCard.changeBG(correct: false)
            rightCardBG?.texture = SKTexture(imageNamed: "card_errado")
            print("Estudante leva hit = ", Student.studentHealth)
            print("Alien da hit = ", alien.alienHealth)
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.changeCardValue()})
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

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        scroller?.stopScroll()
        isInBattle = true
        cardsNeeded = true
        
        if isInBattle && hasTouched == true {
            //Attack.decrease(alunoLife: &Student.studentHealth, alienLife: &alien.alienHealth, ammount: 1)

        }
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
        if isInBattle == true && hasTouched == false{
            
            addCards()
            
            player.zPosition = 3
            player.position = CGPoint(x: -300, y: -80)
            player.texture = SKTexture(image: player.studentImages[0])
            player.size = CGSize(width: 100.0, height: 150.0)
            self.addChild(player)
            
            alien.zPosition = 3
            alien.position = CGPoint(x: 300, y: -80)
            alien.texture = SKTexture(image: alien.alienImages[0])
            alien.size = CGSize(width: 100.0, height: 100.0)
            self.addChild(alien)
            
            playerBeam.zPosition = 2
            playerBeam.position = CGPoint(x: -130, y: -87)
            
            let beamPiece = distanceBetween / Double(playerBeam.numOfLives + alienBeam.numOfLives)
            playerBeam.size = CGSize(width: beamPiece * Double(playerBeam.numOfLives), height: 80.0)
        
            self.addChild(playerBeam)
            
            
            alienBeam.zPosition = 2
            alienBeam.position = CGPoint(x: 150, y: -81)
            
            alienBeam.size = CGSize(width: beamPiece * Double(alienBeam.numOfLives), height: 80.0)
            
            self.addChild(alienBeam)
            isInBattle = false
            
            hasTouched = true
        }
        
        if alien.alienHealth == 0 {
            // passa de fase
            alienBeam.removeFromParent()
            alien.removeFromParent()
            playerBeam.removeFromParent()
            //PLAYER muda de animacao
            alien.alienHealth = Student.studentHealth - 2
            Student.studentHealth = 3
            scroller?.scroll()
        }
        if Student.studentHealth == 0 {
            // game over
            GameScene.gameOver = true
        }
    }
    
    
    
    func addCards () {
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
