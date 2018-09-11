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
    init(poder: Int) {
    }
    
    //MARK: Public Functions
    func increase(alunoLife: Int, alienLife: Int, ammount: Int) -> (newStudentLife:Int, newAlienLife: Int) {
        let novaVidaAluno = alunoLife + ammount
        let novaVidaAlien = alienLife - ammount
    
        return (novaVidaAluno, novaVidaAlien)
    }
    
    func decrease(alunoLife: Int, alienLife: Int, ammount: Int) -> (newStudentLife:Int, newAlienLife: Int) {
        let novaVidaAluno = alunoLife - ammount
        let novaVidaAlien = alienLife + ammount
        
        return (novaVidaAluno, novaVidaAlien)
    }

}
