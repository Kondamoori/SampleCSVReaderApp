//
//  User.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    let firstName: String
    let surName: String
    let issuesCount: Int
    let dateOfBirth: String
}
