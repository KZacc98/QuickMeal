//
//  APIService.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//

import Foundation

///APIService handles communication with the Gemini API and response parsing
class APIService {
    private let apiKey: String
    private let baseURLString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    /**
     Fetches and parses a recipe response from Gemini API
     
     - Parameter prompt: Prompt being sent to Gemini API
     - Returns: `RecipeResponse`
     - Throws: `APIError`
     - Important: This is an async method and must be called with await
     - Note: Handles both network errors and content parsing errors
     - Precondition: Internet connection must be available
     */
    func fetchGeminiResponse(prompt: String) async throws -> RecipeResponse {
        let request = try createRequest(prompt: prompt)
        let (data, _) = try await performRequest(request)
        let geminiResponse = try decodeResponse(data: data)
        
        return try parseContent(from: geminiResponse)
    }
    
    /**
     Creates a URLRequest for the Gemini API
     
     - Parameter prompt: Prompt to Gemini API
     - Returns: Configured URLRequest with JSON payload
     - Throws: `APIError.invalidURL`
     - Note: Uses URLComponents for safe URL construction
     */
    private func createRequest(prompt: String) throws -> URLRequest {
        typealias RequestContent = GeminiRequest.GeminiRequestContent
        
        var components = URLComponents(string: baseURLString)
        components?.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        let requestBody = GeminiRequest(
            contents: [RequestContent(parts: [Part(text: prompt)])]
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        return request
    }
    
    /**
     Performs the network request and validates response
     
     - Parameter request: Configured URLRequest to execute
     - Returns: Tuple containing response data and URLResponse
     - Throws: `APIError.invalidResponse` for non-200 status codes
     - Important: Validates HTTP status code before returning data
     */
    private func performRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse(0)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse(httpResponse.statusCode)
        }
        
        return (data, response)
    }
    
    /**
     Decodes the raw API response data
     
     - Parameter data: Raw response data from the network call
     - Returns: `GeminiResponse`
     - Throws: `APIError.decodingFailed` for invalid response structure
     - Note: Uses JSONDecoder with strict type checking
     */
    private func decodeResponse(data: Data) throws -> GeminiResponse {
        do {
            return try JSONDecoder().decode(GeminiResponse.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingFailed
        }
    }
    
    /**
     Extracts and processes content from API response
     
     - Parameter response: `GeminiResponse`
     - Returns: `RecipeResponse`
     - Throws: `APIError.invalidContent` for missing/malformed content
     - Note: Handles JSON cleaning and final decoding
     */
    private func parseContent(from response: GeminiResponse) throws -> RecipeResponse {
        guard let text = response.candidates.first?.content.parts.first?.text else {
            throw APIError.invalidContent
        }
        
        logTokenUsage(metadata: response.usageMetadata)
        return try parseJSONResponse(from: text)
    }
    
    /**
     Parses cleaned JSON string into domain model
     
     - Parameter jsonString: Raw JSON string from API response
     - Returns: `RecipeResponse`
     - Throws: `APIError.decodingFailed` for invalid JSON structure
     - Important: Handles Markdown code removal
     - Note: Uses regular expressions for JSON cleaning
     */
    private func parseJSONResponse(from jsonString: String) throws -> RecipeResponse {
        let cleanedString = jsonString
            .replacingOccurrences(of: "```(json)?", with: "", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let data = cleanedString.data(using: .utf8) else {
            throw APIError.decodingFailed
        }
        
        do {
            return try JSONDecoder().decode(RecipeResponse.self, from: data)
        } catch {
            print("Content decoding error: \(error)")
            throw APIError.decodingFailed
        }
    }
    
    /**
     Logs token usage statistics from API response
     
     - Parameter metadata: Usage metadata from GeminiResponse
     */
    private func logTokenUsage(metadata: GeminiResponse.UsageMetadata) {
        print("""
        \n
        Token Usage:
        - Prompt: \(metadata.promptTokenCount)
        - Candidates: \(metadata.candidatesTokenCount)
        - Total: \(metadata.totalTokenCount)
        \n
        """)
    }
}
