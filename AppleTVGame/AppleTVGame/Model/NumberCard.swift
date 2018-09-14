//
//  NumberCard.swift
//  AppleTVGame
//
//  Created by Guilherme Vassallo on 13/09/2018.
//  Copyright © 2018 Felipe Kestelman. All rights reserved.
//

import Foundation
import SpriteKit

typealias Rational = (num : Int, den : Int)

public class NumberCard {
    
    var cardBG: UIImage!
    let numberValue: Float!
    var numberDisplay: String?
    
    
    func convertNumber(value: Float){
        let possibility = arc4random_uniform(3) + 1
        
        switch possibility {
        case 1: //só mostra o número como o valor decimal
            
            self.numberDisplay = "\(value)"
            //print ("\(String(describing: self.numberDisplay))")
            
        case 2: //mostra número como porcentagem
            
            let cardString = "\(100 * value)%"
            self.numberDisplay = cardString
            //print ("\(String(describing: self.numberDisplay))")
            
        case 3: //mostra o número como fração
            
            var fraction: Rational
            
            fraction = rationalApproximation(of: Double(numberValue))
            
            let cardString = "\(fraction.num)/\(fraction.den)"
            self.numberDisplay = cardString
            
        default:
            self.numberDisplay = "U DONE F****** IT UP"
        }
    }
    
    
    
    func changeBG (correct: Bool){
        if correct == true{
            self.cardBG = UIImage(named: "card_correto")
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

func rationalApproximation(of x0 : Double, withPrecision eps : Double = 1.0E-6) -> Rational {
    var x = x0
    var a = x.rounded(.down)
    var (h1, k1, h, k) = (1, 0, Int(a), 1)
    
    while x - a > eps * Double(k) * Double(k) {
        x = 1.0/(x - a)
        a = x.rounded(.down)
        (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
    }
    return (h, k)
}
/*func findMinMultiplier (denominator: Int, numerator: Int, divider: Int) -> (Int, Int){
    if divider > denominator || divider > numerator {
        print ("divider > denominator -> \(denominator)")
        return (denominator, divider)
    }
    
    else if denominator % divider != 0 && numerator % divider != 0 {
        let newDivider = divider + 1
        print ("denominator % divider != 0  -> \(denominator)")
        return findMinMultiplier(denominator: denominator, numerator: numerator, divider: newDivider)
    }
    else{
        print ("denominator % divider = 0 -> \(denominator)")
        return findMinMultiplier(denominator: denominator/divider, numerator:
            numerator/divider, divider: divider)
    }
}*/
