# AppRatingDialog

[//]: <> ([![CI Status](https://img.shields.io/travis/kuzdu/AppRatingDialog.svg?style=flat)](https://travis-ci.org/kuzdu/AppRatingDialog))
[![Version](https://img.shields.io/cocoapods/v/AppRatingDialog.svg?style=flat)](https://cocoapods.org/pods/AppRatingDialog)
[![License](https://img.shields.io/cocoapods/l/AppRatingDialog.svg?style=flat)](https://cocoapods.org/pods/AppRatingDialog)
[![Platform](https://img.shields.io/cocoapods/p/AppRatingDialog.svg?style=flat)](https://cocoapods.org/pods/AppRatingDialog)


## Installation

To install AppRatingDialog, simply add the following line to your Podfile:

```ruby
pod 'AppRatingDialog'
```
Then run `pod install`

## Description

AppRatingDialog is a practically framework for getting app store reviews or feedback via email.

If you ask the user for an app ranking, this should be done in a user-friendly way.  

Apple recommends
> You can ask users to rate and review your app at appropriate times throughout the user experience.
> Make the request when users are most likely to feel satisfaction with your app, such as when they’ve completed an action, level, or task.
> Make sure not to interrupt their activity.

Further indications are that the user may only be asked about the StoreKit 3 times a year. AppRatingDialog takes care of this. In addition, users who do not like the app are asked to send feedback by e-mail. 

![alt text](app_rating_dialog_flow.png "App Rating Flow")

Please check out the `App Rating Dialog Flow`. Of course you can edit the appearance as well as the text keys and views. See the example and/or documentation.

## How To Implement

### Must have 
It is easy and fast to show the rating dialog. 
```swift
import AppRatingDialog

// init app rating presentre
lazy var appRatingPresenter = {
       return AppRatingDialogPresenter(viewController: self, feedbackMailRecipient: "feedback@my_company.com")
   }()
   
// show rating dialog
appRatingPresenter.showRating()
```

### Optional

All text keys:
```swift
public var initialTitle = "Do you like the App?"
public var initialMessage = "If you have a minute, give us some feedback. This helps us improve the app."
public var initalNegativButtonTitle = "No"
public var initalPositivButtonTitle = "Yes"

public var noLikeTitle = "Oh - okay"
public var noLikeMessage = "We are sorry to hear that. Please tell us what bothers you so that we can implement your feedback."
public var noLikeNegativButtonTitle = "No"
public var noLikePositivButtonTitle = "Yes"

public var feedbackMailRecipient = "enter_your_mail_here@company.com"
public var feedbackMailTitle = "Feedback"
public var feedbackMailMessage = "Your feedback here:\n"
```

It is recommended to think about when the user will be asked for a rating. Situations such as the following are useful: 

* After successfully completing a level
* After receiving a service (ticket, bank transfer, in-app purchase ...)
* If it is an experienced and returning user



## Roadmap

* ➡️ use Localizable for default text values
* ➡️ Integrate CITravis for quality
* ➡️ Einstellbar, wie oft der View gezeigt werden soll "Not yet", "Never Again", "Yes"
* ➡️ Configurable how often the screen is displayed when the user does not want to give feedback
* ➡️ add custom image
* ➡️ add lottie animation 


## Author

michael.rothkegel@invers.com / rothkegel.michael@gmail.com and manuel.weiel@invers.com (http://manuel.weiel.eu/)

## License

AppRatingDialog is available under the MIT license. See the LICENSE file for more info.
