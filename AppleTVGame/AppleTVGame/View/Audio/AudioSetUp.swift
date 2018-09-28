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
    func alienDefeatedAudio()
    func alienAppearsAudio()
    func themeSongAudio(stop: Bool)
    func battleSongAudio(stop: Bool)
    func rightCardAudio()
    func wrongCardAudio()
    func battleWonAudio()
    
}

class AudioSetUp: AudioSetUpDelegate {
    
    var beamStartSound: AVAudioPlayer?
    var beamLoopSound: AVAudioPlayer?
    var alienDefeatedSound: AVAudioPlayer?
    var alienAppearsSound: AVAudioPlayer?
    var themeSongSound: AVAudioPlayer?
    var battleSongSound: AVAudioPlayer?
    var rightCardSound: AVAudioPlayer?
    var wrongCardSound: AVAudioPlayer?
    var battleWonSound: AVAudioPlayer?
    
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
        beamLoopSound?.volume = 1.5
        if stop == false {
            beamLoopSound?.numberOfLoops = -1
            beamLoopSound?.play()
        }
        else {
            beamLoopSound?.stop()
        }
    }
    
    func alienDefeatedAudio() {
        
        let Path = Bundle.main.path(forResource: "alien_defeated", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            alienDefeatedSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load alienDefeatedSound :O
        }
        
        alienDefeatedSound?.play()
    }
    
    func alienAppearsAudio() {
        
        let Path = Bundle.main.path(forResource: "alien_growl", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            alienAppearsSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load alienAppearsSound :O
        }
        
        alienAppearsSound?.play()
    }
    
    func themeSongAudio(stop: Bool) {
        
        let Path = Bundle.main.path(forResource: "nonstop_numbers_theme_short", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            themeSongSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load themeSongSound :O
        }
        if stop == false {
            themeSongSound?.numberOfLoops = -1
            themeSongSound?.play()
        }
        else {
            themeSongSound?.stop()
        }
    }
    
    func battleSongAudio(stop: Bool) {
        
        let Path = Bundle.main.path(forResource: "nonstop_numbers_battle_theme_short", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            battleSongSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load battleSongSound :O
        }
        if stop == false {
            battleSongSound?.numberOfLoops = -1
            battleSongSound?.play()
        }
        else {
            battleSongSound?.stop()
        }
    }
    
    func rightCardAudio() {
        
        let Path = Bundle.main.path(forResource: "right_card_sound", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            rightCardSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load rightCardSound :O
        }
        
        rightCardSound?.volume = 0.7
        rightCardSound?.play()
    }
    
    func wrongCardAudio() {
        
        let Path = Bundle.main.path(forResource: "wrong_card_sound", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            wrongCardSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load wrongCardSound :O
        }
        
        wrongCardSound?.volume = 0.7
        wrongCardSound?.play()
    }
    
    func battleWonAudio() {
        
        let Path = Bundle.main.path(forResource: "battle_won", ofType: "mp3")!
        let Url = URL(fileURLWithPath: Path)
        do{
            battleWonSound = try AVAudioPlayer(contentsOf: Url)
        } catch {
            // couldnt load battleWonSound :O
        }
        
        battleWonSound?.volume = 0.8
        battleWonSound?.play()
    }
}
