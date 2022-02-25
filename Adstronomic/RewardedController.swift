//
//  RewardedController.swift
//  My Super Game
//
//  Created by Pythony on 29/12/2021.
//

import AVKit

class RewardedController: AVPlayerViewController {
    
    private var close: Close? = nil
    
    func setClose(close: Close) {
        self.close = close;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let link = Adstronomic.getRewardedClick()
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url).resume()
        } else {
            print("Incorrect URL")
        }
        
        if let url = URL(string: Adstronomic.getRewardedRedirection()) {
            UIApplication.shared.open(url)
        } else {
            print("Unable to Redirect")
        }
        
        self.close?.close()
    }
    
}
