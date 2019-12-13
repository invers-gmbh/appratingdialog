//
//  AppRatingMFMailComposeViewControllerDelegate.swift
//  AppRating
//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//

import Foundation
import MessageUI

class AppRatingDialogMFMailComposeViewControllerDelegate: NSObject, MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
