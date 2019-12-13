//
//  Copyright © 2019 INVERS GmbH. All rights reserved.
//
import Foundation

class AppRatingDialogLogic {
    init() {}
    
    // MARK: - computed properties
    private var nextDateForRatingQuestion: Double {
        return UserDefaults.standard.double(forKey: AppRatingDialogConstants.nextDateForRatingQuestionKey)
    }
    
    private var currentVersion: String? {
        get {
            #if TESTS
            return "1.0.0"
            #endif
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        }
    }
    
    private var lastKnowVersion: String? {
        return UserDefaults.standard.value(forKey: AppRatingDialogConstants.lastKnownVersionKey) as? String
    }
    
    // MARK: - privates
    private func isDateNotInLastFourMonths() -> Bool {
        return Date().timeIntervalSince1970 > nextDateForRatingQuestion + AppRatingDialogConstants.fourMonth
    }
    
    // MARK: - publics
    func saveRatedVersion() {
        let lastRatedDate = Date().timeIntervalSince1970
        UserDefaults.standard.set(lastRatedDate, forKey: AppRatingDialogConstants.nextDateForRatingQuestionKey)
        UserDefaults.standard.set(currentVersion, forKey: AppRatingDialogConstants.lastKnownVersionKey)
    }
    
    func isAllowedToShowRatingView() -> Bool {
        #if DEBUG
        return true
        #endif
        
        return isDateNotInLastFourMonths() && currentVersion != self.lastKnowVersion
    }
}
