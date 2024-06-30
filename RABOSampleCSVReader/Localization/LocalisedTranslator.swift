//
//  LocalisedTranslator.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation

/// Type which used access localised keys.
enum LocalizedTranslator {
    
    enum UserListViewTranslation {
        static let firstName = NSLocalizedString("firstName", comment: "")
        static let surName = NSLocalizedString("surName", comment: "")
        static let dateOfBirth = NSLocalizedString("dateOfBirth", comment: "")
        static let issuesCount = NSLocalizedString("issuesCount", comment: "")
    }
    
    enum LoadingViewTranslation {
        static let loading = NSLocalizedString("loading", comment: "")
    }
    
    enum CSVScreenTranslation {
        static let title = NSLocalizedString("viewTitle", comment: "")
    }
    
    enum AlertViewTranslation {
        static let okButtonTitle = NSLocalizedString("ok", comment: "")
        static let alertViewTitle = NSLocalizedString("alertTitle", comment: "")
        static let defaultAlertMessage = NSLocalizedString("alertMessage", comment: "")
        static let dismissButtonTitle = NSLocalizedString("ok", comment: "")
    }
    
    enum TabTitlesTranslation {
        static let gridLayout = NSLocalizedString("gridLayout", comment: "")
        static let tableLayout = NSLocalizedString("tableLayout", comment: "")
    }

}
