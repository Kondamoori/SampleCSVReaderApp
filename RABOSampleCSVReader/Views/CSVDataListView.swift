//
//  CSVDataListView.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation
import SwiftUI

/// View To show user list
struct CSVDataListView: View {
    
    // MARK: - Internal properties
    
    let userList: [User]
    
    var body: some View {
        NavigationView(content: {
            List(userList) { user in
                UserCellView(user: user)
            }
        })
    }
}

/// Cell View to show user detail
struct UserCellView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let firstName = LocalizedTranslator.UserListViewTranslation.firstName
        static let surName = LocalizedTranslator.UserListViewTranslation.surName
        static let dateOfBirth = LocalizedTranslator.UserListViewTranslation.dateOfBirth
        static let numberOfIssues = LocalizedTranslator.UserListViewTranslation.issuesCount
    }
    
    // MARK: - Internal properties
    
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(Constants.firstName): \(user.firstName)").font(.headline)
                Text("\(Constants.surName): \(user.surName)").font(.subheadline)
                Text("\(Constants.dateOfBirth): \(user.dateOfBirth)").font(.subheadline)
            }
            Spacer()
            Text("\(Constants.numberOfIssues): \(user.issuesCount)").font(.headline)
        }.padding()
    }
}

// MARK: - Preview

#Preview {
    CSVDataListView(userList: [User(firstName: "123", surName: "12312", issuesCount: 1, dateOfBirth: "35235")])
}
