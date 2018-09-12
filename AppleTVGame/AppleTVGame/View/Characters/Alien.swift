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

class Alien {
    public var vidaAlien: Float
    var alienImage: UIImage
    var alienSound: AVAudioPlayer?
    
    init(life: Float, imagemAlien: UIImage) {
        self.vidaAlien = life
        self.alienImage = imagemAlien
    }
}
