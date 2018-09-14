//
//  Alien.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 10/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class Alien: SKSpriteNode {
    var alienHealth: Double
    var alienImages: [UIImage]
    var alienSound: AVAudioPlayer?
    
    init(life: Double, imagensAlien: [UIImage]) {
        let texture = SKTexture(imageNamed: "Alien1")
        self.alienHealth = life
        self.alienImages = imagensAlien
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
