//
//  ApiRequest.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation

/// Type to support different app environments.
enum Environment: String {
    case production = "https://rabo.sampleapi.com/"
    case test = "https://test.rabo.sampleapi.com/"
    case acceptance = "https://accp.rabo.sampleapi.com/"
    case offline // Fixed local file always with specific name
}

private enum Constants {
    static let offlineFileName = "issues"
    static let fileExtension = "csv"
}

struct ApiRequest {
    
    // MARK: - Internal Properties

    let path: String
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [String: String]?
    let environment: Environment
  
    var request: URLRequest? {
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        if  let headers = headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        return request
    }
    
    // MARK: - Private Properties

    private var urlComponents: URLComponents? {
        // May be we can also think alternate approach to load offline/mock data.
        if environment == .offline, let fileURL = Bundle.main.url(forResource: Constants.offlineFileName, withExtension: Constants.fileExtension) {
            return URLComponents(url: fileURL, resolvingAgainstBaseURL: false)
        }
        let base: String = environment.rawValue
        var component = URLComponents(string: base)
        component?.path = path
        return component
    }
    
    // MARK: - Life cycle

    init(endPoint: EndPoint, environment: Environment = .production) {
        self.httpMethod = endPoint.method
        self.path = endPoint.path
        self.body = endPoint.body
        self.headers = endPoint.headers
        self.environment = environment
    }
}
