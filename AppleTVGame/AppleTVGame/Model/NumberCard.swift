//
//  NumberCard.swift
//  AppleTVGame
//
//  Created by Guilherme Vassallo on 13/09/2018.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import Foundation
import SpriteKit

public class NumberCard {
    
    var cardBG: UIImage!
    let numberValue: Float!
    var numberDisplay: String?
    
    
    func convertNumber(value: Float){
        let possibility = arc4random_uniform(3) + 1
        
        switch possibility {
        case 1: //só mostra o número como o valor decimal
            
            self.numberDisplay = "\(value)"
            print ("\(String(describing: self.numberDisplay))")
            
        case 2: //mostra número como porcentagem
            
            let cardString = "\(100 * value)%"
            self.numberDisplay = cardString
            print ("\(String(describing: self.numberDisplay))")
            
        case 3: //mostra o número como fração
            
            var denominator = Int(100 * value)
            var numerator = 100
            
            (denominator, numerator) = findMinMultiplier (denominator: denominator, numerator: numerator, divider: 2) //acha o mmc da fração
            
            self.numberDisplay = "\(denominator)/\(numerator)"
            //print ("\(String(describing: self.numberDisplay))")
            
        default:
            self.numberDisplay = "U DONE F****** IT UP"
        }
    }
    
    
    
    func changeBG (correct: Bool){
        if correct == true{
            self.cardBG = UIImage(named: "card_certo")
        }
        else{
            self.cardBG = UIImage(named: "card_errado")
        }
    }
    
    func resetBG () {
        self.cardBG = UIImage(named: "card_neutro")
    }
    
    
    
    init(cardBG: UIImage, numberValue: Float){
        self.cardBG = cardBG
        self.numberValue = numberValue
    }
    
}




//essa função não faz parte da classe
func findMinMultiplier (denominator: Int, numerator: Int, divider: Int) -> (Int, Int){
    if divider > denominator || divider > numerator {
        return (denominator, divider)
    }
    
    else if denominator % divider > 0 && numerator % divider > 0 {
        return findMinMultiplier(denominator: denominator/divider, numerator: numerator/divider, divider: divider)
    }
    else{
        let newDivider = divider + 1
        return findMinMultiplier(denominator: denominator, numerator: numerator, divider: newDivider)
    }
}
