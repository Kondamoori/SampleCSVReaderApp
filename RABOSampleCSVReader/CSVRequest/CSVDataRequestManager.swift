//
//  CSVDataRequestManager.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation

/// CSVData end point, which contains all details to make URLRequest.
enum CSVDataEndPoint: EndPoint {
    
    case studentCSV
    
    var path: String {
        switch self {
        case .studentCSV:
            return "issues"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .studentCSV:
            return .get
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var contentType: ContentType {
        return .JSON
    }
    
    var headers: [String: String]? {
        var newHeaders = [String: String]()
        newHeaders["Content-Type"] = contentType.rawValue
        return newHeaders
    }
}

/// Request manager to fetch CSV data
struct CSVDataRequestManager {
    
    // MARK: - Private properties
    
    private let requestManager: NetworkRequestManagerInterface
            
    // MARK: - Init
    
    init(requestManager: NetworkRequestManagerInterface) {
        self.requestManager = requestManager
    }
    
    // MARK: - Internal functions
    
    /// Function to fetch data form CSVData end point.
    /// - Returns: array of strings.
    func fetchData() async throws -> Data {
        let apiRequest = ApiRequest(endPoint: CSVDataEndPoint.studentCSV, environment: .offline)
        guard let urlRequest = apiRequest.request else {
            throw ApiError.requestError
        }
        
        let csvData: Data = try await requestManager.performRequest(request: urlRequest)
        return csvData
    }
}
