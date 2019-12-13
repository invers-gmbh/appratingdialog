//
//  RatingPresenter.swift
//  Pods-AppRating_Example
//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//

import Foundation
import StoreKit
import UIKit
import MessageUI

public class AppRatingDialogPresenter {
    // MARK: - private state
    private let viewController: UIViewController
    private let feedbackMailRecipient: String
    
    private let appRateDialogMailDelegate = AppRatingDialogMFMailComposeViewControllerDelegate()
    private let appRatingDialogLogic = AppRatingDialogLogic()

    private var backgroundView: UIView?
    
    private var hasAnsweredFirstQuestion = false
    private var bottomConstraint: NSLayoutConstraint!

    public var appRateDialogView: AppRatingDialogView!
    
    // MARK: - public state
    public init(viewController: UIViewController, feedbackMailRecipient: String) {
        self.viewController = viewController
        self.feedbackMailRecipient = feedbackMailRecipient
        self.appRateDialogView = initRateView()
    }
    
    public func showRating() {
        removeViews()
        
        if !appRatingDialogLogic.isAllowedToShowRatingView() {
            return
        }
                
        let loadedBackgroundView = initBackgroundView()
        backgroundView = loadedBackgroundView
        
        addBackground(backgroundView: loadedBackgroundView)
        addRateView(appRateView: appRateDialogView)
        initConstraints(for: appRateDialogView)
        showRateViewAnimation()
    }
    
    // init
    private func initRateView() -> AppRatingDialogView {
        // load rating view
        let bundle = Bundle(identifier: AppRatingDialogConstants.bundleIdentifier)
        guard let loadedAppRateView = bundle?.loadNibNamed(AppRatingDialogConstants.ratingViewNibName, owner: nil, options: nil)?.first as? AppRatingDialogView else {
            fatalError("Could not load `RatingView` from storyboard")
        }
        
        // style
        loadedAppRateView.translatesAutoresizingMaskIntoConstraints = false
        loadedAppRateView.layer.cornerRadius = 10
        loadedAppRateView.backgroundColor = UIColor.white
        
        loadedAppRateView.titleLabel.text = AppRatingDialogTextConstants.shared.initialTitle
        loadedAppRateView.titleLabel.textColor = loadedAppRateView.titleLabel.textColor
        
        loadedAppRateView.messageLabel.text = AppRatingDialogTextConstants.shared.initialMessage
        loadedAppRateView.messageLabel.textColor = UIColor.black
        
        loadedAppRateView.yesButton.setTitleColor(UIColor.white, for: .normal)
        loadedAppRateView.yesButton.backgroundColor = UIColor.blue
        loadedAppRateView.yesButton.layer.cornerRadius = 10
        loadedAppRateView.yesButton.setTitle(AppRatingDialogTextConstants.shared.initialPositiveButtonTitle, for: .normal)
        
        loadedAppRateView.noButton.setTitle(AppRatingDialogTextConstants.shared.initialNegativeButtonTitle, for: .normal)
        loadedAppRateView.noButton.layer.cornerRadius = 10
        loadedAppRateView.noButton.layer.borderColor = UIColor.blue.cgColor
        loadedAppRateView.noButton.layer.borderWidth = 1.0
        loadedAppRateView.noButton.setTitleColor(UIColor.blue, for: .normal)
        loadedAppRateView.noButton.backgroundColor = UIColor.clear
        
        // set listener
        loadedAppRateView.onYesButton = {
            self.onYesButtonClicked()
        }
        loadedAppRateView.onNoButton = {
            self.onNoButtonClicked()
        }
        
        return loadedAppRateView
    }
    
    // move to logic
    private func showSendFeedbackEmail() {
        if !MFMailComposeViewController.canSendMail() {
            print("Device is not able to send mails.")
            return
        }
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = appRateDialogMailDelegate
        mail.setToRecipients([feedbackMailRecipient])
        mail.setSubject(AppRatingDialogTextConstants.shared.feedbackMailTitle)
        let bodyMessage = AppRatingDialogTextConstants.shared.feedbackMailMessage
        mail.setMessageBody(bodyMessage, isHTML: true)
        viewController.present(mail, animated: true)
    }
    
    // MARK: - add
    private func initBackgroundView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideRatingView)))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isHidden = true
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    
    private func addBackground(backgroundView: UIView) {
        viewController.view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
    }
    
    private func addRateView(appRateView: AppRatingDialogView) {
        viewController.view.addSubview(appRateView)
    }
    
    // MARK: - buttons clicked
    private func onNoButtonClicked() {
        appRatingDialogLogic.saveRatedVersion()
        if hasAnsweredFirstQuestion {
            hideRatingView()
        } else {
            hasAnsweredFirstQuestion = true
            goToMailDialog()
        }
    }
    
    private func onYesButtonClicked() {
        appRatingDialogLogic.saveRatedVersion()
        if hasAnsweredFirstQuestion {
            showSendFeedbackEmail()
        } else {
            SKStoreReviewController.requestReview()
        }
        hideRatingView()
    }
    
    // MARK: - setter
    private func initConstraints(for view: UIView) {
        var leadingAnchor: NSLayoutXAxisAnchor!
        var trailingAnchor: NSLayoutXAxisAnchor!
        var bottomAnchor: NSLayoutYAxisAnchor!
        
        if #available(iOS 11, *) {
            leadingAnchor = viewController.view.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor = viewController.view.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor = viewController.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            leadingAnchor = viewController.view.leadingAnchor
            trailingAnchor = viewController.view.trailingAnchor
            bottomAnchor = viewController.view.bottomAnchor
        }
        
        bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomOffset(for: view, isDown: true))
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomConstraint
        ])
    }
    
    private func bottomOffset(for view: UIView?, isDown: Bool) -> CGFloat {
        guard let view = view else {
            return 0.0
        }
        return isDown ? 16 + view.frame.height : -16
    }
    
    // MARK: - show
    private func showRateViewAnimation() {
        viewController.view.layoutIfNeeded()
        backgroundView?.isHidden = false

        bottomConstraint.constant = bottomOffset(for: appRateDialogView, isDown: false)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.viewController.view.layoutIfNeeded()
        })
    }
    
    private func goToMailDialog() {
        UIView.animate(withDuration: 0.125, animations: {
            self.appRateDialogView?.messageLabel.alpha = 0.1
        }) { (_) in
            self.appRateDialogView?.yesButton.setTitle(AppRatingDialogTextConstants.shared.noLikePositiveButtonTitle, for: .normal)
            self.appRateDialogView?.noButton.setTitle(AppRatingDialogTextConstants.shared.noLikeNegativeButtonTitle, for: .normal)
            self.appRateDialogView?.messageLabel.text = AppRatingDialogTextConstants.shared.noLikeMessage
            self.appRateDialogView?.titleLabel.text = AppRatingDialogTextConstants.shared.noLikeTitle
            
            UIView.animate(withDuration: 0.5, animations: {
                self.appRateDialogView?.messageLabel.alpha = 1
                self.appRateDialogView?.titleLabel.alpha = 1
            })
        }
    }
    
    private func removeViews() {
        self.appRateDialogView?.removeFromSuperview()
        self.backgroundView?.removeFromSuperview()
    }
    
    // MARK: - hide
    @objc private func hideRatingView() {
        hasAnsweredFirstQuestion = false
        
        bottomConstraint.constant = bottomOffset(for: appRateDialogView, isDown: true)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.backgroundView?.alpha = 0
            self.viewController.view.layoutIfNeeded()
        }, completion: { (_) in
            self.removeViews()
        })
    }
}
