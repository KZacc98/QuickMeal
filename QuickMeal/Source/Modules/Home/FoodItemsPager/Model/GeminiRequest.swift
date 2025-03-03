//
//  GeminiRequest.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 03/03/2025.
//

/**
 Represents the request body structure for Gemini API
 
 - Note: Mirrors the exact structure required by Gemini API
 - SeeAlso: [Gemini API Documentation](https://ai.google.dev/gemini-api/docs/quickstart)
 */
struct GeminiRequest: Encodable {
    let contents: [GeminiRequestContent]
    
    struct GeminiRequestContent: Encodable {
        let parts: [Part]
    }
}
