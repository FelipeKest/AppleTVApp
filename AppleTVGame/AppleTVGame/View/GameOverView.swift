//
//  GameOverView.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 20/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit

class GameOverView: UIView {
    
    static var firstTimeBeingPresented: Bool! = true
    
    var vc: UIViewController?
    
    init(frame: CGRect, vc: UIViewController) {
        super.init(frame: frame)
        self.vc = vc
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Adiciona a view na controller correspondente
    func addCustomView() {
        
        let x = self.frame.width
        let y = self.frame.height
        
        let startBtn: UIButton = UIButton(type: .system)
        let optionsBtn: UIButton = UIButton(type: .system)
        
        // Defino a posicao
        startBtn.frame=CGRect(x: (UIScreen.main.bounds.width/2)-180,y: (UIScreen.main.bounds.height/2)+50, width: 400, height: 100)
        startBtn.frame.origin.x =  ((x)/4) - (startBtn.frame.width/2)
        startBtn.frame.origin.y =  y/2 - (startBtn.frame.height/2)
        
        optionsBtn.frame=CGRect(x: (UIScreen.main.bounds.width/2)-180,y: (UIScreen.main.bounds.height/2)+50, width: 400, height: 100)
        optionsBtn.frame.origin.x =  ((3*x)/4) - (startBtn.frame.width/2)
        optionsBtn.frame.origin.y =  y/2 - (startBtn.frame.height/2)

        // Cor do fundo do butao
        startBtn.backgroundColor = UIColor.clear
        optionsBtn.backgroundColor = UIColor.clear
        // Legenda
        startBtn.setTitle("Iniciar", for: UIControl.State.normal)
        optionsBtn.setTitle("Help", for: UIControl.State.normal)
        
        // Fonte e tamanho
        startBtn.titleLabel?.font = UIFont(name: "GothamLight", size: 20.0)
        optionsBtn.titleLabel?.font = UIFont(name: "GothamLight", size: 20.0)
        
        print("coloquei o bobao do butao")
        // Coloco ele na tela e falo a acao dele
        optionsBtn.addTarget(self, action: #selector(optionsMenu(sender:)), for: .primaryActionTriggered)
        startBtn.addTarget(self, action: #selector(startGame(sender:)), for: .primaryActionTriggered)
        
        //Add na view
        self.addSubview(startBtn)
        self.addSubview(optionsBtn)
    }
    
    //Segue para retornar o menu
    @objc func optionsMenu(sender: UIButton!){
        self.vc?.performSegue(withIdentifier: "oprionsSegue", sender: self)
    }
    
    @objc func startGame(sender: UIButton!){
        GameScene.gameOver = false
        self.vc?.performSegue(withIdentifier: "startSegue", sender: self)
    }
}
