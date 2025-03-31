//
//  GeminiAPIServiceProtocol.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 31/03/2025.
//

protocol GeminiAPIServiceProtocol {
    func fetchGeminiResponse(prompt: String) async throws -> RecipeResponse
}
