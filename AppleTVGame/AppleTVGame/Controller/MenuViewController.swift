//
//  MenuViewController.swift
//  AppleTVGame
//
//  Created by Guilherme Vassallo on 28/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    var audio: AudioSetUpDelegate!

    override func viewDidLoad() {
        
        audio = AudioSetUp()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        audio.themeSongAudio(stop: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audio.themeSongAudio(stop: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
