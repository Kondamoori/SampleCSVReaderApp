//
//  ApiError.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 29/06/2024.
//

import Foundation

/// Custom Error type
enum ApiError: Error, LocalizedError, Equatable {
    case requestError
    case invalidResponse
    case parsingError
    case unAuthorized
    case forbidden
    case notFound
    case unknownError(httpResponse: HTTPURLResponse, data: Data)
}
