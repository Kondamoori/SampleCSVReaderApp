//
//  CSVDataViewViewModel.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation
import Combine
import TabularData

enum DataViewMode {
    case plainList
    case gridLayout
}

@MainActor
final class CSVDataViewViewModel: ObservableObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let columnNames = ["First name", "Sur name", "Issue count", "Date of birth"]
    }
    
    // MARK: - Internal properties
    
    @Published var isLoading = false
    @Published var dataFrame: DataFrame = DataFrame()
    @Published var users: [User] = []
    var errorMessage: String?
    let viewMode: DataViewMode

    // MARK: - Private properties
    
    private let csvReadingOptions: CSVReadingOptions
    private let dataRequestManager: CSVDataRequestManager
    
    // MARK: - Initialisation
    
    init(csvReadingOptions: CSVReadingOptions = CSVReadingOptions(),
         dataRequestManager: CSVDataRequestManager,
         viewMode: DataViewMode = .gridLayout) {
        self.csvReadingOptions = csvReadingOptions
        self.dataRequestManager = dataRequestManager
        self.viewMode = viewMode
    }
    
    // MARK: - Internal functions
    
    func loadCSVData() async throws {
        isLoading = true
        do {
            guard let data = try? await dataRequestManager.fetchData() else {
                isLoading = false
                throw ApiError.notFound
            }
            
            // Check layout and parse data accordingly
            if viewMode == .gridLayout {
               dataFrame = try parseCSV(data: data)
            } else {
                users = try parseCSVIntoModels(data: data)
            }
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Private functions
    
    private func parseCSV(data: Data) throws -> DataFrame {
        do {
            let dataFrame = try DataFrame(csvData: data, options: self.csvReadingOptions)
            return dataFrame
        } catch {
            throw ApiError.invalidResponse
        }
    }
    
    private func parseCSVIntoModels(data: Data) throws -> [User] {
        do {
            let table = try DataFrame(csvData: data, options: self.csvReadingOptions)
            var users = [User]()
            for row in table.rows {
                if let firstName = row[Constants.columnNames[0]] as? String,
                   let surName = row[Constants.columnNames[1]] as? String,
                   let issueCount = row[Constants.columnNames[2]] as? Int,
                   let dateOfBirth = row[Constants.columnNames[3]] as? String {
                    users.append(User(firstName: firstName, surName: surName, issuesCount: issueCount, dateOfBirth: dateOfBirth))
                }
            }
            return users
        } catch {
            throw ApiError.invalidResponse
        }
    }
}
