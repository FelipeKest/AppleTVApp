//
//  GameOverView.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 20/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit

class GameOverView: UIView {
    
    var vc: GameViewController?
    
    init(frame: CGRect, vc: GameViewController) {
        super.init(frame: frame)
        self.vc = vc
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override var canBecomeFocused: Bool {
//        return true
//    }
//
//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        switch context.nextFocusedView {
//        case returnBtn:
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
//            }, completion: nil)
//        case restartBtn:
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
//            }, completion: nil)
//        default:
//            return
//        }
//        switch context.previouslyFocusedView {
//        case returnBtn:
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
//            }, completion: nil)
//        case restartBtn:
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
//            }, completion: nil)
//        default:
//            return
//        }
//    }
    
    //Adiciona a view na controller correspondente
    func addCustomView() {
        
        let x = self.frame.width
        let y = self.frame.height
        
        let returnBtn: UIButton = UIButton(type: .system)
        let restartBtn: UIButton = UIButton(type: .system)
        
        // Defino a posicao
        returnBtn.frame=CGRect(x: (UIScreen.main.bounds.width/2)-180,y: (UIScreen.main.bounds.height/2)+50, width: 400, height: 100)
        returnBtn.frame.origin.x =  ((x)/4) - (returnBtn.frame.width/2)
        returnBtn.frame.origin.y =  y/2 - (returnBtn.frame.height/2)
        
        restartBtn.frame=CGRect(x: (UIScreen.main.bounds.width/2)-180,y: (UIScreen.main.bounds.height/2)+50, width: 400, height: 100)
        restartBtn.frame.origin.x =  ((3*x)/4) - (returnBtn.frame.width/2)
        restartBtn.frame.origin.y =  y/2 - (returnBtn.frame.height/2)

        // Cor do fundo do butao
        returnBtn.backgroundColor = UIColor.clear
        restartBtn.backgroundColor = UIColor.clear
        // Legenda
        returnBtn.setTitle("Retornar ao Menu", for: UIControl.State.normal)
        restartBtn.setTitle("Reiniciar", for: UIControl.State.normal)
        
        // Fonte e tamanho
        returnBtn.titleLabel?.font = UIFont(name: "GothamLight", size: 20.0)
        restartBtn.titleLabel?.font = UIFont(name: "GothamLight", size: 20.0)
        
        print("coloquei o bobao do butao")
        // Coloco ele na tela e falo a acao dele
        returnBtn.addTarget(self, action: #selector(returnToMenu(sender:)), for: .touchDown)
        restartBtn.addTarget(self, action: #selector(restartGame(sender:)), for: .touchDown)
        
        //Add na view
        self.addSubview(returnBtn)
        self.addSubview(restartBtn)
    }
    
    //Segue para retornar o menu
    @objc func returnToMenu(sender: UIButton!){
        print("foi o return")
        self.vc!.dismiss(animated: false, completion: nil)
        GameScene.gameOver = false
    }
    
    @objc func restartGame(sender: UIButton!){
        print("foi o restart")
        
    }

}
