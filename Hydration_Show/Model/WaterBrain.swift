//
//  WaterBrain.swift
//  Waterproject
//
//  Created by Tigger on 1/9/2020.
//  Copyright © 2020 Tigger. All rights reserved.
//

import Foundation

struct WaterCalculator {
    
    
    var weight:Double
    var activity:Int
    
    init(w:Double,act:Int) {
        self.activity = act
        self.weight = w
    }
    
    var litre : Double {
        return 22.18 * (weight * 1.47 + Double(activity) * 12)
    }
    
        
    func getWater() -> String {
        let litreTo2DecimalPlace = String(format: "%.2f", litre)
        return litreTo2DecimalPlace
    }
    
}
