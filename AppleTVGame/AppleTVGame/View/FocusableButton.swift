//
//  FocusableButton.swift
//  AppleTVGame
//
//  Created by Felipe Kestelman on 20/09/18.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import UIKit

class FocusableButton: UIButton {
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
            }, completion: nil)
            
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.black.cgColor
            }, completion: nil)
        }
    }
    
    
}
