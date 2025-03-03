//
//  GeminiResponse.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 03/03/2025.
//

/**
 Represents the complete response structure from Gemini API
 
 - Note: Contains both content and usage metadata
 */
struct GeminiResponse: Decodable {
    let usageMetadata: UsageMetadata
    let candidates: [Candidate]
    let modelVersion: String
    
    struct UsageMetadata: Decodable {
        let promptTokenCount: Int
        let candidatesTokenCount: Int
        let totalTokenCount: Int
        let promptTokensDetails: [TokenDetail]?
        let candidatesTokensDetails: [TokenDetail]?
    }
    
    struct TokenDetail: Decodable {
        let modality: String
        let tokenCount: Int
    }
    
    struct Candidate: Decodable {
        let content: CandidateContent
        let finishReason: String
        let avgLogprobs: Double?
    }
    
    struct CandidateContent: Decodable {
        let parts: [Part]
        let role: String
    }
}
