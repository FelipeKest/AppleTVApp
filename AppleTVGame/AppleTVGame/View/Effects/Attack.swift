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
    static func increase( alunoLife: inout Double, alienLife: inout Double, ammount: Double) {
        alunoLife += ammount
        alienLife -= ammount
    }
    
    static func decrease(alunoLife: inout Double, alienLife: inout Double, ammount: Double) {
        alunoLife -= ammount
        alienLife += ammount
    }

}
