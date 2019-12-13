//
//  PresenterConfig.swift
//  AppRating
//
//  Copyright © 2019 INVERS GmBH. All rights reserved.
//
import Foundation

public class AppRatingDialogTextConstants {
    private init() {}
    
    public static let shared = AppRatingDialogTextConstants()

    public var initialTitle = "Do you like the App?"
    public var initialMessage = "If you have a minute, give us some feedback. This helps us improve the app."
    public var initialNegativeButtonTitle = "No"
    public var initialPositiveButtonTitle = "Yes"
    
    public var noLikeTitle = "Oh - okay"
    public var noLikeMessage = "We are sorry to hear that. Please tell us what bothers you so that we can implement your feedback."
    public var noLikeNegativeButtonTitle = "No"
    public var noLikePositiveButtonTitle = "Yes"
    
    public var feedbackMailTitle = "Feedback"
    public var feedbackMailMessage = "Your feedback here:\n"
}
