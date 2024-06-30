//
//  NetworkRequestManager.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation
import TabularData

/// Network request manager interface.
protocol NetworkRequestManagerInterface {
    func performRequest<T: Decodable>(request: URLRequest) async throws -> T
    func performRequest(request: URLRequest) async throws -> Data
}

/// Network manager which responsible for the perform request.
class NetworkRequestManager: NetworkRequestManagerInterface {
    
    /// Function to perform request
    /// - Parameter request: instance of URL Request.
    /// - Returns: returns the parsed data by Type inferring if no error.
    func performRequest<T: Decodable>(request: URLRequest) async throws -> T {
        let (responseData, httpResponse) = try await URLSession.shared.data(for: request)
        let data = try parseHttpResponse(response: (responseData, httpResponse))
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return jsonData
        } catch {
            throw ApiError.parsingError
        }
    }
    
    func performRequest(request: URLRequest) async throws -> Data {
        let (responseData, httpResponse) = try await URLSession.shared.data(for: request)
        let data = try parseHttpResponse(response: (responseData, httpResponse))
        return data
    }
    
    /// Function to parse HTTP Response from perform request of NetworkRequestManager.
    /// - Parameter response: response object with (Data, URLResponse)
    /// - Returns: instance of Data if httpResponse.statusCode 200..<300.
    func parseHttpResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw ApiError.requestError
        case 401:
            throw ApiError.unAuthorized
        case 403:
            throw ApiError.forbidden
        case 404:
            throw ApiError.notFound
        default:
            throw ApiError.unknownError(httpResponse: httpResponse, data: response.data)
        }
    }
}
