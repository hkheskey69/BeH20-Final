//
//  UserProfile.swift
//  Hydration Profile
//
//  Created by Jason So on 1/9/2020.
//  Copyright © 2020 Jason So. All rights reserved.
//

import Foundation

struct UserProfile : Codable {
    
    let gender : String
    let age : Int
    let height : Double
    let weight : Double
    let activity : String
    
    var waterTarget : Int {
            return Int((1.47*self.weight+Double(12*self.activityLevel))*22.18)
    }
    
    var activityLevel : Int {
        get {
            switch self.activity {
            case "0" :
                return 0
            case "1" :
                return 1
            case "2" :
                return 2
            default :
                return 3
            }
        }
    }
    
    var waterDrank : Int = 0
    
    var waterPercentage : Double {
        return Double(waterDrank)/Double(waterTarget)*100
    }
    
}
