//
//  CSVEndPointTests.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation
import XCTest
@testable import RABOSampleCSVReader

final class CSVEndPointTests: XCTestCase {
    
    private var sut: CSVDataEndPoint!
    
    override func setUp() {
        super.setUp()
        sut = .studentCSV
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCSVEndPoint() {
        XCTAssertEqual(sut, .studentCSV)
        XCTAssertNil(sut.body)
        XCTAssertEqual(sut.contentType, .JSON)
        XCTAssertEqual(sut.path, "issues")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.headers, ["Content-Type" : "application/json"])
    }
}
