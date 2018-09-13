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
    static var alienHealth: Double = 300
    var alienImage: UIImage
    var alienSound: AVAudioPlayer?
    
    init(life: Double, imagemAlien: UIImage) {
        Alien.alienHealth = life
        self.alienImage = imagemAlien
    }
}
