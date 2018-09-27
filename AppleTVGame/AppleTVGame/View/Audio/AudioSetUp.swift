//
//  AudioSetUp.swift
//  AppleTVGame
//
//  Created by Guilherme Vassallo on 27/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioSetUpDelegate {
    func beamStartAudio()
    func beamLoopAudio(stop: Bool)
    
}

class AudioSetUp: AudioSetUpDelegate {
    
    var beamStartSound: AVAudioPlayer?
    var beamLoopSound: AVAudioPlayer?
    
    
    func beamStartAudio() {
        
        let Path = Bundle.main.path(forResource: "beamRelease", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            beamStartSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load beamstartsound :O
        }
        
        beamStartSound?.play()
    }
    
    func beamLoopAudio(stop: Bool) {
        let Path = Bundle.main.path(forResource: "beamLoop", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            beamLoopSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load beamloopsound :O
        }
        if stop == false {
            beamLoopSound?.numberOfLoops = -1
            beamLoopSound?.play()
        }
        else {
            beamLoopSound?.stop()
        }
    }
    
    
    
}
