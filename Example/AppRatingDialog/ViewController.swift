//
//  ViewController.swift
//  AppRatingDialog
//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//

import UIKit
import AppRatingDialog

class ViewController: UIViewController {
    @IBAction func showRatingButtonAction(_ sender: Any) {
        appRatingPresenter.showRating()
    }
    
    lazy var appRatingPresenter = {
        return AppRatingDialogPresenter(viewController: self, feedbackMailRecipient: "feedback@my_company.com")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(AppRatingDialogVersionNumber)
        customizeAppRatingTexts()
    }
        
    func customizeAppRatingTexts() {
        AppRatingDialogTextConstants.shared.initialTitle = "Please rate"
        AppRatingDialogTextConstants.shared.initialMessage = "If you have a minute, give us some feedback. This is will help us to improve the app."
    }
}

