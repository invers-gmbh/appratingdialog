//
//  RateView.swift
//  Pods-AppRating_Example
//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//

import Foundation
import UIKit

public class AppRatingDialogView: UIView {
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var messageLabel: UILabel!
    @IBOutlet public weak var yesButton: UIButton!
    @IBOutlet public weak var noButton: UIButton!
    
    @IBAction func noButtonAction(_ sender: Any) {
        onNoButton?()
    }
    
    @IBAction func yesButtonAction(_ sender: Any) {
        onYesButton?()
    }
    
    var onYesButton: (() -> Void)?
    var onNoButton: (() -> Void)?
}
