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
    static let instance = Student()
    
    static var studentHealth: Double = 250
    var studentImages: [UIImage]  = [UIImage(named: "player_attacking")!]
    
    
    private init() {
        let texture = SKTexture(imageNamed: "player_attacking")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
