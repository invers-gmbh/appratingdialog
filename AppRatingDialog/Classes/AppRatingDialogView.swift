//
//  RateView.swift
//  Pods-AppRating_Example
//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//

import Foundation
import UIKit

public class AppRatingDialogView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBAction func noButtonAction(_ sender: Any) {
        onNoButton?()
    }
    
    @IBAction func yesButtonAction(_ sender: Any) {
        onYesButton?()
    }
    
    var onYesButton: (() -> Void)?
    var onNoButton: (() -> Void)?
}
