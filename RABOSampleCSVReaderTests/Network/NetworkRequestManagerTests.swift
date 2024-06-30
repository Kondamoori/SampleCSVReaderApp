//
//  NetworkRequestManagerTests.swift
//  RABOSampleCSVReaderTests
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import XCTest
@testable import RABOSampleCSVReader

final class NetworkRequestManagerTests: XCTestCase {
    
    func testNetworkRequestHttpResponseParsingWithSuccessCase() throws {
        let sut = NetworkRequestManager()
        let url = URL(string: "/test")!
        let httpUrlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let response = httpUrlResponse as URLResponse
        let succesCase = ("test".data(using: .utf8)!, response)
        
        let result = try sut.parseHttpResponse(response: succesCase)
        
        XCTAssertEqual(String(data: result, encoding: .utf8), "test")
    }
    
    func testNetworkRequestHttpResponseParsingWithApiRequestError() throws {
        let sut = NetworkRequestManager()
        let url = URL(string: "/test")!
        let httpUrlResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
        
        let response = httpUrlResponse as URLResponse
        let errorCaseResult = ("test".data(using: .utf8)!, response)
        
        do {
            _ = try sut.parseHttpResponse(response: errorCaseResult)
        } catch (let error as ApiError){
            XCTAssertEqual(ApiError.requestError, error)
        }
    }
    
    func testNetworkRequestHttpResponseParsingWithUnauthorisedError() throws {
        let sut = NetworkRequestManager()
        let url = URL(string: "/test")!
        let httpUrlResponse = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)!
        
        let response = httpUrlResponse as URLResponse
        let errorCaseResult = ("test".data(using: .utf8)!, response)
        
        do {
            _ = try sut.parseHttpResponse(response: errorCaseResult)
        } catch (let error as ApiError){
            XCTAssertEqual(ApiError.unAuthorized, error)
        }
    }
    
    func testNetworkRequestHttpResponseParsingWithForbiddenError() throws {
        let sut = NetworkRequestManager()
        let url = URL(string: "/test")!
        let httpUrlResponse = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil)!
        
        let response = httpUrlResponse as URLResponse
        let errorCaseResult = ("test".data(using: .utf8)!, response)
        
        do {
            _ = try sut.parseHttpResponse(response: errorCaseResult)
        } catch (let error as ApiError){
            XCTAssertEqual(ApiError.forbidden, error)
        }
    }
    
    func testNetworkRequestHttpResponseParsingWithResourceNotFoundError() throws {
        let sut = NetworkRequestManager()
        let url = URL(string: "/test")!
        let httpUrlResponse = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        let response = httpUrlResponse as URLResponse
        let errorCaseResult = ("test".data(using: .utf8)!, response)
        
        do {
            _ = try sut.parseHttpResponse(response: errorCaseResult)
        } catch (let error as ApiError){
            XCTAssertEqual(ApiError.notFound, error)
        }
    }
    
}
