//
//  ApiRequestTests.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation
import XCTest
@testable import RABOSampleCSVReader

final class ApiRequestTests: XCTestCase {

    var sut: ApiRequest!
    
    override func setUp() {
        super.setUp()
        sut = ApiRequest(endPoint: MockEndPoint(), environment: .acceptance)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testApiRequestInitialisation() {
        // Assert
        XCTAssertEqual(sut.path, "/testPath")
        XCTAssertEqual(sut.httpMethod, .get)
        XCTAssertEqual(sut.environment, .acceptance)
        XCTAssertEqual(sut.body, "test".data(using: .utf8))
        XCTAssertEqual(sut.headers, ["header": "test"])
    }
    
    func testUrlRequestCreationFromEndPoint() throws {
        // Assert
        let request = try XCTUnwrap(sut.request)
        let requestMethod = try XCTUnwrap(request.httpMethod)
        let requestBody = try XCTUnwrap(request.httpBody)
        let requestUrl = try XCTUnwrap(request.url)
        print(requestUrl.path)

        XCTAssertEqual(String(decoding: requestBody, as: UTF8.self), "test")
        XCTAssertEqual(requestMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(requestUrl, URL(string: "https://accp.rabo.sampleapi.com/testPath"))
    }
    
    func testUrlRequestCreationFromEndPointForOfflineMode() throws {
        // Arrange
        sut = ApiRequest(endPoint: MockEndPoint(), environment: .offline)

        // Assert
        let request = try XCTUnwrap(sut.request)
        let requestMethod = try XCTUnwrap(request.httpMethod)
        let requestBody = try XCTUnwrap(request.httpBody)
        let requestUrl = try XCTUnwrap(request.url)
        print(requestUrl.path)

        XCTAssertEqual(String(decoding: requestBody, as: UTF8.self), "test")
        XCTAssertEqual(requestMethod, HTTPMethod.get.rawValue)
        let expectedURL = try XCTUnwrap(Bundle.main.url(forResource: "issues", withExtension: "csv"))
        XCTAssertEqual(requestUrl, expectedURL)
    }
}


struct MockEndPoint: EndPoint {
    
    var path: String {
        "/testPath"
    }
    
    var method: RABOSampleCSVReader.HTTPMethod {
        .get
    }
    
    var body: Data? {
        "test".data(using: .utf8)
    }
    
    var headers: [String : String]? {
        ["header": "test"]
    }
    
    var contentType: RABOSampleCSVReader.ContentType {
        .JSON
    }
}
