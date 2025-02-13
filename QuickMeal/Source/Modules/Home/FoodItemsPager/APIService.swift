//
//  APIService.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//

import Foundation

class APIService {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchGeminiResponse(prompt: String) async throws -> String {
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            throw NSError(domain: "GeminiAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode JSON"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "GeminiAPI", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid response from API"])
        }
        
        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let usageMetadata = jsonResponse["usageMetadata"] as? [String: Any],
           let totalTokensUsed = usageMetadata["totalTokenCount"] as? Int,
           let candidates = jsonResponse["candidates"] as? [[String: Any]],
           let content = candidates.first?["content"] as? [String: Any],
           let parts = content["parts"] as? [[String: Any]],
           let text = parts.first?["text"] as? String {
            print("\n")
            print("Tokens used: \(totalTokensUsed) \n")
            print("API Response: \n")
            print("\n")
            print(jsonResponse)
            print("\n")
            print("\n")
            dump(parseJSONResponse(from: text))
            
            return text
        } else {
            throw NSError(domain: "GeminiAPI", code: -3, userInfo: [NSLocalizedDescriptionKey: "Failed to parse API response"])
        }
    }
    
    private func parseJSONResponse(from jsonString: String) -> RecipeResponse? {
        guard let jsonData = jsonString
            .replacingOccurrences(of: "```", with: "")
            .replacingOccurrences(of: "json", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .data(using: .utf8) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(RecipeResponse.self, from: jsonData)
            return decodedResponse
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

