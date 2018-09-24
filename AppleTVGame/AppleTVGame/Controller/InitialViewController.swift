//
//  InitialViewController.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 24/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = GameOverView(frame: UIScreen.main.bounds, vc: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print(GameOverView.firstTimeBeingPresented!)
    }
}
