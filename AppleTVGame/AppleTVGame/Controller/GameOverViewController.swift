//
//  GameOverViewController.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 24/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = GameOverView(frame: UIScreen.main.bounds, vc: self)
    }
    
}
