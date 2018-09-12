//
//  HitBeam.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 11/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit
import SpriteKit

class HitBeam: SKSpriteNode {
    var beamBody: UIImage
    var beamEnd: UIImage
    var beamBodyParticle: SKEmitterNode
    var beamEndParticle: SKEmitterNode
    var beamSize: Float
    
    init(body: UIImage, end: UIImage, bodyParticle: SKEmitterNode, endParticle: SKEmitterNode, beamPower: Float){
        let texture = SKTexture(imageNamed: "")
        self.beamBody = body
        self.beamEnd = end
        self.beamBodyParticle = bodyParticle
        self.beamEndParticle = endParticle
        self.beamSize = beamPower
        super.init(texture: texture, color: UIColor.red, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increase(alunoLife: Float, alienLife: Float, ammount: Float) -> (newStudentLife: Float, newAlienLife: Float) {
        let novaVidaAluno = alunoLife + ammount
        let novaVidaAlien = alienLife - ammount
        
        return (novaVidaAluno, novaVidaAlien)
    }
    
    func decrease(alunoLife: Float, alienLife: Float, ammount: Float) -> (newStudentLife: Float, newAlienLife: Float) {
        let novaVidaAluno = alunoLife - ammount
        let novaVidaAlien = alienLife + ammount
        
        return (novaVidaAluno, novaVidaAlien)
    }
    
}
