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
    
    //MARK: Propriedades
 
    //MARK: Initializer
    
    //MARK: Public Functions
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
