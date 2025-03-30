//
//  APIError.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 03/03/2025.
//

/// Represents possible API errors
enum APIError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse(Int)
    case decodingFailed
    case invalidContent
    case unknownError
}
