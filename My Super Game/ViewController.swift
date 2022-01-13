//
//  ViewController.swift
//  My Super Game
//
//  Created by Pythony on 27/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Adstronomic.initialize(campaignId: "SMSdtSBHg8PAvPq7PmC1", viewController: self)
    }
    
    @IBAction func bannerAd(_ sender: Any) {
        Adstronomic.loadBanner(imageView: imageView)
    }

    @IBAction func interstitialAd(_ sender: Any) {
        Adstronomic.loadInterstitial()
    }

    @IBAction func rewardedAd(_ sender: Any) {
        Adstronomic.loadRewarded()
    }

}
