//
//  AdEnum.swift
//  My Super Game
//
//  Created by Pythony on 05/01/2022.
//

import Foundation

enum AdEnum: String {
    case Banner
    case Interstitial
    case Rewarded
    
    var get: String {
        if(self == .Banner) {
            return "banner"
        } else if(self == .Interstitial) {
            return "interstitial"
        } else if(self == .Rewarded) {
            return "rewarded"
        } else {
            return ""
        }
    }

}
