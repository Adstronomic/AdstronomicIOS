//
//  ViewController.swift
//  My Super Game
//
//  Created by Pythony on 15/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Adstronomic.initialize(campaignId: "SMSdtSBHg8PAvPq7PmC1", viewController: self)
    }

    @IBAction func bannerAd(_ sender: Any) {
        Adstronomic.loadBanner(imageView: self.imageView)
    }

    @IBAction func interstitialAd(_ sender: Any) {
        Adstronomic.loadInterstitial()
    }
    
    @IBAction func rewardedAd(_ sender: Any) {
        Adstronomic.loadRewarded()
    }
}
