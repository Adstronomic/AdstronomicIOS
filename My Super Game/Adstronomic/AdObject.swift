//
//  Ad.swift
//  My Super Game
//
//  Created by Pythony on 27/12/2021.
//

import Foundation

public class AdObject: Codable {

    public let advertiserCampaignId: String
    public let url: String
    public let type: String
    public let redirection: String
    
    public init(advertiserCampaignId: String, url: String, type: String, redirection: String) {
        self.advertiserCampaignId = advertiserCampaignId
        self.url = url
        self.type = type
        self.redirection = redirection
    }
    
    public static func empty() -> AdObject {
        return AdObject(advertiserCampaignId: "", url: "", type: "", redirection: "")
    }

}
