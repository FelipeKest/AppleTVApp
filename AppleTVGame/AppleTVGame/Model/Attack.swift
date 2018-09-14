//
//  Attack.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 10/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import Foundation
import SpriteKit

class Attack {
    
    //MARK: Public Functions
    static func increase(alunoLife: Double, alienLife: Double, ammount: Double) -> (newStudentLife: Double, newAlienLife: Double) {
        let novaVidaAluno = alunoLife + ammount
        let novaVidaAlien = alienLife - ammount
    
        return (novaVidaAluno, novaVidaAlien)
    }
    
    static func decrease(alunoLife: Double, alienLife: Double, ammount: Double) -> (newStudentLife: Double, newAlienLife: Double) {
        let novaVidaAluno = alunoLife - ammount
        let novaVidaAlien = alienLife + ammount
        
        return (novaVidaAluno, novaVidaAlien)
    }

}
