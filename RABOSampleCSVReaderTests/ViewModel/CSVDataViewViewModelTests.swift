//
//  CSVDataViewViewModelTests.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation
import XCTest
@testable import RABOSampleCSVReader

final class CSVDataViewViewModelTests: XCTestCase {
    var sut: CSVDataViewViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        sut = CSVDataViewViewModel(dataRequestManager: CSVDataRequestManager(requestManager: MockNetworkRequestManager()))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func testParseCSVSuccess() async throws {
        // Arrange
        XCTAssertTrue(sut.dataFrame.rows.isEmpty)
        
        // Act
        try await sut.loadCSVData()
        
        // Assert
        XCTAssertEqual(sut.dataFrame.rows.count, 1)
        XCTAssertEqual(sut.dataFrame.columns.count, 2)
    }
    
    @MainActor
    func testParseCSVFailed() async throws {
        // Arrange
        let mockRequestManager = MockNetworkRequestManager()
        mockRequestManager.shouldReturnError = true
        sut = CSVDataViewViewModel(dataRequestManager: CSVDataRequestManager(requestManager: mockRequestManager))
        
        // Assert
        XCTAssertTrue(sut.dataFrame.rows.isEmpty)
        
        // Act
        do {
            try await sut.loadCSVData()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertNotNil(sut.errorMessage)
        }
        
        // Assert
        XCTAssertTrue(sut.dataFrame.rows.isEmpty)
    }
}

private final class MockNetworkRequestManager: NetworkRequestManagerInterface {
    var shouldReturnError: Bool = false
    
    func performRequest<T>(request: URLRequest) async throws -> T where T : Decodable {
        throw ApiError.parsingError
    }
    
    func performRequest(request: URLRequest) async throws -> Data {
        if shouldReturnError {
            throw ApiError.invalidResponse
        }
        
        let csvString = "column1,column2\nvalue1,value2"
        return csvString.data(using: .utf8)!
    }
}
