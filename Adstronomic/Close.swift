//
//  Close.swift
//  My Super Game
//
//  Created by Pythony on 16/02/2022.
//

import AVKit

class Close: UIButton {

    var playerViewController: AVPlayerViewController = AVPlayerViewController()
    var timer: Timer = Timer()
    var seconds: Int = 0

    required init(playerViewController: AVPlayerViewController) {
        super.init(frame: .zero)

        self.playerViewController = playerViewController
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.oneSecond)), userInfo: nil, repeats: true)
        self.seconds = Config.videoDelay / 1000

        self.frame = CGRect(x: 30, y: 60, width: 50, height: 50)
        self.setTitle(String(self.seconds), for: .normal)
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func close() {
        self.playerViewController.removeFromParent()
        self.playerViewController.view.removeFromSuperview()

        self.playerViewController.player?.pause()
        self.playerViewController.player?.replaceCurrentItem(with: nil)
        
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(self.seconds == 0) {
            self.close()
        }
    }
    
    @objc public func oneSecond() {
        if(self.seconds >= 2) {
            self.seconds -= 1

            self.setTitle(String(self.seconds), for: .normal)
        } else {
            self.seconds = 0

            self.setTitle("X", for: .normal)
        }
    }

}
