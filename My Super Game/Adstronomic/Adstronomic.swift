//
//  Adstronomic.swift
//  My Super Game
//
//  Created by Pythony on 27/12/2021.
//

import Foundation
import UIKit

import AVFoundation
import AVKit

public class Adstronomic {
    
    private static var api: String = ""
    private static var campaignId: String = ""
    
    private static var bannerAdObject: AdObject = AdObject.empty()
    private static var bannerAdImage: UIImage = UIImage()
    
    private static var interstitialAdObject: AdObject = AdObject.empty()
    private static var interstitialPlayer: AVPlayer = AVPlayer()
    private static var interstitialViewController: UIViewController = UIViewController()
    
    private static var rewardedAdObject: AdObject = AdObject.empty()
    private static var rewardedPlayer: AVPlayer = AVPlayer()
    private static var rewardedViewController: UIViewController = UIViewController()
    
    private static var bannerAdBuffer: AdObject = AdObject.empty()
    private static var interstitialAdBuffer: AdObject = AdObject.empty()
    private static var rewardedAdBuffer: AdObject = AdObject.empty()
    
    public static func initialize(campaignId: String, viewController: UIViewController) {
        if(Config.version == "1.0.0") {
            self.api = Config.link
            self.campaignId = campaignId
            self.interstitialViewController = viewController
            self.rewardedViewController = viewController
            
            self.fetchBanner()
            self.fetchInterstitial()
            self.fetchRewarded()

            print("Adstronomic is Ready !")
        } else {
            print("Initialization Failed !")
        }
    }
    
    public static func loadBanner(imageView: UIImageView) {
        if(self.bannerAdObject.advertiserCampaignId != "") {
            self.adVisualized(adType: AdEnum.Banner, advertiserCampaignId: self.bannerAdObject.advertiserCampaignId)
            
            DispatchQueue.main.async {
                imageView.image = self.bannerAdImage

                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.redirect)))

                fetchBanner()
            }
        } else {
            print("No Banner Ad")
        }
    }
    
    public static func fetchBanner() {
        let link = self.api + "getAd?adType=banner&publisherCampaignId=" + self.campaignId
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error -> Void in
                if let data = data, let ad = try? JSONDecoder().decode(AdObject.self, from: data) {
                    if(Config.bannerAdTypes.contains(ad.type)) {
                        self.bannerAdBuffer = self.bannerAdObject
                        self.bannerAdObject = ad
                        
                        if let url = URL(string: self.bannerAdObject.url) {
                            DispatchQueue.global().async { [] in
                                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                    self.bannerAdImage = image
                                } else {
                                    print("Incorrect Datas")
                                }
                            }
                        } else {
                            print("Incorrect URL")
                        }
                    } else {
                        print("Incorrect Type")
                    }
                } else {
                    print("Incorrect Datas")
                }
            }.resume()
        } else {
            print("Incorrect URL")
        }
    }
    
    public static func loadInterstitial() {
        if(self.interstitialAdObject.advertiserCampaignId != "") {
            self.adVisualized(adType: AdEnum.Interstitial, advertiserCampaignId: self.interstitialAdObject.advertiserCampaignId)
            
            let playerViewController = InterstitialController()
            playerViewController.player = self.interstitialPlayer

            self.interstitialViewController.present(playerViewController, animated: true) {
                self.interstitialPlayer.play()
            }

            fetchInterstitial()
        } else {
            print("No Interstitial Ad")
        }
    }
    
    public static func fetchInterstitial() {
        let link = self.api + "getAd?adType=interstitial&publisherCampaignId=" + self.campaignId
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error -> Void in
                if let data = data, let ad = try? JSONDecoder().decode(AdObject.self, from: data) {
                    if(Config.interstitialAdTypes.contains(ad.type)) {
                        self.interstitialAdBuffer = self.interstitialAdObject
                        self.interstitialAdObject = ad

                        if let url = URL(string: self.interstitialAdObject.url) {
                            self.interstitialPlayer = AVPlayer(url: url)
                        } else {
                            print("Incorrect URL")
                        }
                    } else {
                        print("Incorrect Type")
                    }
                } else {
                    print("Incorrect Datas")
                }
            }.resume()
        } else {
            print("Incorrect URL")
        }
    }

    public static func loadRewarded() {
        if(self.rewardedAdObject.advertiserCampaignId != "") {
            self.adVisualized(adType: AdEnum.Rewarded, advertiserCampaignId: self.rewardedAdObject.advertiserCampaignId)

            let playerViewController = RewardedController()
            playerViewController.player = self.rewardedPlayer

            self.rewardedViewController.present(playerViewController, animated: true) {
                self.rewardedPlayer.play()
            }

            fetchRewarded()
        } else {
            print("No Rewarded Ad")
        }
    }
    
    public static func fetchRewarded() {
        let link = self.api + "getAd?adType=rewarded&publisherCampaignId=" + self.campaignId
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error -> Void in
                if let data = data, let ad = try? JSONDecoder().decode(AdObject.self, from: data) {
                    if(Config.rewardedAdTypes.contains(ad.type)) {
                        self.rewardedAdBuffer = self.rewardedAdObject
                        self.rewardedAdObject = ad

                        if let url = URL(string: self.rewardedAdObject.url) {
                            self.rewardedPlayer = AVPlayer(url: url)
                        } else {
                            print("Incorrect URL")
                        }
                    } else {
                        print("Incorrect Type")
                    }
                } else {
                    print("Incorrect Datas")
                }
            }.resume()
        } else {
            print("Incorrect URL")
        }
    }

    private static func adVisualized(adType: AdEnum, advertiserCampaignId: String) {
        let link = self.api + "adVisualized?adType=" + adType.get + "&publisherCampaignId=" + self.campaignId + "&advertiserCampaignId=" + advertiserCampaignId

        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url).resume()
        } else {
            print("Incorrect URL")
        }
    }
    
    @objc private static func redirect(sender: UITapGestureRecognizer) {
       let link = self.api + "click?clicked=true&type=banner&publisherCampaignId=" + self.campaignId + "&advertiserCampaignId=" + self.bannerAdBuffer.advertiserCampaignId
       
       if let url = URL(string: link) {
           URLSession.shared.dataTask(with: url).resume()
       } else {
           print("Incorrect URL")
       }
       
       if let url = URL(string: self.bannerAdBuffer.redirection) {
           UIApplication.shared.open(url)
       } else {
           print("Unable to Redirect")
       }
    }
    
    public static func getInterstitialClick() -> String {
        return self.api + "click?clicked=true&type=interstitial&publisherCampaignId=" + self.campaignId + "&advertiserCampaignId=" + self.interstitialAdBuffer.advertiserCampaignId
    }
    
    public static func getInterstitialRedirection() -> String {
        return self.interstitialAdBuffer.redirection
    }

    public static func getRewardedClick() -> String {
        return self.api + "click?clicked=true&type=rewarded&publisherCampaignId=" + self.campaignId + "&advertiserCampaignId=" + self.rewardedAdBuffer.advertiserCampaignId
    }
    
    public static func getRewardedRedirection() -> String {
        return self.rewardedAdBuffer.redirection
    }

}
