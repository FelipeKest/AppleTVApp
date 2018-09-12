//
//  Student.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 10/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit
import SpriteKit

class Student:SKSpriteNode {
    let instance = Student()
    
    var studentHealth: Float = 3
//    var studentImages: [UIImage]  = [UIImage(named: "Student")]
    
    private init() {
        
        let texture = SKTexture(imageNamed: "Student")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
