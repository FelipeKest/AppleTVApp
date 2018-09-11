//
//  Student.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 10/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit
import SpriteKit

class Student {
    public var vidaAluno: Int
    var studentImages: [UIImage]
    
    init(life: Int, imagensEstudante: [UIImage]) {
        self.vidaAluno = life
        self.studentImages = imagensEstudante
    }
    
}
