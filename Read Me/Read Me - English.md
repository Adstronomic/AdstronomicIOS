## [**🇫🇷 VERSION FRANÇAISE DISPONIBLE 🇫🇷**](https://github.com/Adstronomic/AdstronomicIOS/blob/master/Read%20Me/Read%20Me%20-%20French.md)



# **Adstronomic - Installation Guide (iOS)**



## <u>1 - Introduction</u>



Adstronomic is an advertising platform that allows you to leverage and synthesize your users' data to deliver the most relevant advertising to them. By taking into account the specificities of each game and its users, coupled with a revolutionary AI, we can identify the most relevant ads to increase your game's revenues. To achieve this, Adstronomic offers three key tools :

	- A web platform where you can set up your projects and associated ads.
	- An API that allows you to interact with Adstronomic data.
	- An SDK that allows you to quickly and easily use the full potential of Adstronomic

Each of these tools is intuitive, so you can focus on what matters most to you : The success of your project. In this guide, we will focus on the third point : Installing and using the SDK, here in its iOS version. 📱

Please note that there are two solutions available to you : If you start a new project, we invite you to clone this repository directly, and use it as a working base. This will allow you to skip the section "2 - Creating a new project". However, if your project is already well advanced, you will probably prefer to install the SDK to your existing project. In this case, the next section is for you !



## <u>2 - Creating a new project</u>



As an iOS developer, you are probably familiar with Xcode, Apple's default development tool. So let's launch it, and create a new project.

Start by choosing "iOS" in the top menu, then select "App". You can use any name and Organization Identifier you want. However, make sure you have selected the "Storyboard" interface, and the "Swift" language.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/1.png" alt="Adstronomic-iOS-1" style="zoom:25%;" />

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/2.png" alt="Adstronomic-iOS-2" style="zoom:25%;" />

As you are starting from an empty project, you will have to add the SDK manually. To do this, clone this project, find the "Adstronomic" folder, and copy its contents, which are six files. Go back to Xcode, and create a new group (I kept the name "Adstronomic", but you can rename it) in your project, into which you paste these six files. Note that copy and paste may not work in some cases, and you will have to replace it with drag and drop.

You should normally have a tree structure like this :

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/3.png" alt="Adstronomic-iOS-3" style="zoom:25%;" />

Congratulations ! You've just added Adstronomic to your project ! 🥳 The next step is now to configure it !



## <u>3 - SDK configuration</u>



Now that Adstronomic is integrated into your project, let's see how to set it up so that it retrieves and sends the right data.

As a reminder, we are in a Storyboard, and the entry point of our project is the "ViewController.swift" file. So we will open it. You should have the following content :

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
```

Comments are removed from the examples I will give, for the sake of clarity.

The first step is to initialize Adstronomic. To do this, we will use the following function in the constructor :

```swift
Adstronomic.initialize(campaignId: "SMSdtSBHg8PAvPq7PmC1", viewController: self)
```

🚨 Note that the first parameter is the campaign ID, as indicated on the web platform. The username shown here is a demo account, which can be used to check how Adstronomic works, but should definitely not be deployed in production !

This function will allow Adstronomic to connect properly to the API, and will automatically load and cache an ad of each type (Banner Ad, Interstitial Ad and Rewarded Ad) to speed up its display later on.



## <u>4 - Loading a Banner Ad</u>



A BannerAd is simply an advertisement in the form of an image, usually displayed at the bottom of the screen during a game. The advantage of this type of display is that it does not block the rest of the screen, and can therefore be displayed throughout the game.

In Adstronomic, these ads are represented by classic images, of type UIImageView. So we will manually add one to our project. To do this, open the "Main.storyboard" file.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/4.png" alt="Adstronomic-iOS-4" style="zoom: 25%;" />

If you open this file for the first time, you should normally see a blank screen. This is normal ! I added a StackView to my project containing a Label, three Buttons, and a UIImageView, which are optional at this stage. We will only need the UIImageView, which you can add if you don't have one.

Now that we have our UIImageView on our stage, we just need to retrieve it from the ViewController.swift file, by dragging it. Once this is done, our ad is ready to be loaded.

The only step is to call the function :

```swift
Adstronomic.loadBanner(imageView: imageView)
```

This function takes as parameter a UIImageView, which is the one we have just retrieved.

Where to call this function ? Well, that's up to you. You can load it from the beginning, so that your ad appears as soon as it is launched, or wait for a specific action. As we are on a test project here, I made sure to call it when a button is clicked, which is present in the storyboard we just saw. But you can call it at any event of your application.

```swift
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

}
```

We can now launch our application, and see the result. When we click on the button, the ad is loaded, and is displayed at the bottom of our application.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/5.png" alt="Adstronomic-iOS-5" style="zoom:25%;" />



## <u>5 - Loading an Interstitial Ad</u>



If you have successfully displayed a Banner Ad, you should have no difficulty in displaying Interstitial Ad and Rewarded Ad, as they are used almost the same way. Let's go back to the Main.storyboard, and this time add an AVKit Player View Controller. This is the equivalent of a UIImageView, for videos.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/6.png" alt="Adstronomic-iOS-6" style="zoom:25%;" />

Note that this is a bit of a special component, as it will take up all the space of your scene, and should therefore be placed next to your scene, so as not to hide it.

The difference with the Banner Ad is that once our AVKit Player View Controller is added, we don't have to take care of it anymore. In fact, the Adstronomic SDK will automatically pick it up when we load our video ad.

So how do we do this ? By calling the following function :

```swift
Adstronomic.loadInterstitial()
```

Note that, like the Banner Ad, you can launch the video at any time. I did it here when clicking a new button, but you can do it as soon as the application is launched, or at any other event.

```swift
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

}
```

By launching the application, and clicking on the corresponding button, our video ad should appear in full screen.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/7.png" alt="Adstronomic-iOS-7" style="zoom:25%;" />



## <u>6 - Loading a Rewarded Ad</u>



Ready for the final step ?

Rewarded Ads are video ads similar to Interstitial Ads. The difference is that they have a different marketing goal, and are more focused on rewarding a specific action. Technically speaking, they work the same way, except that you have to use the loadRewarded function and not loadInterstitial.

```swift
Adstronomic.loadRewarded()
```

As for the first two ads, this code can be executed at any time in your application. Here is the complete code that loads and launches a Rewarded Ad as soon as the third and last button of the storyboard is clicked :

```swift
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
```

And the result on our iPhone is the following, after a click on the corresponding button.

<img src="https://raw.githubusercontent.com/Adstronomic/AdstronomicIOS/master/Read%20Me/8.png" alt="Adstronomic-iOS-8" style="zoom:25%;" />

That's it ! You are now an Adstronomic pro ! 😎



## <u>7 - Conclusions and Resources</u>



Through this guide, we have installed, initialized and used Adstronomic's iOS SDK. Of course, this SDK integrates with the rest of the Adstronomic ecosystem, and I strongly encourage you to learn more about it.

To do so, here are a few links that will be helpful :

    Website : https://www.adstronomic.com
    Campaign Manager : https://app.adstronomic.com
    Our GCU : https://terms.adstronomic.com
    Our GitHub : https://www.github.com/adstronomic
    Our Discord : https://discord.gg/Uz5EMFpWuU

The last step for you is to sign up for our campaign manager, create a campaign, add your ads, and specify your campaignId when the application loads.

Finally, Adstronomic thrives on our users, and it is our duty to do our best for them. If you have any comments, questions, or suggestions, we invite you to send us a feedback via our contact page or our Discord.

See you soon,

The Adstronomic Team ✌️
