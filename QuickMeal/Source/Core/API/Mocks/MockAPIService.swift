//
//  MockAPIService.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 31/03/2025.
//

class MockAPIService: GeminiAPIServiceProtocol {
    func fetchGeminiResponse(prompt: String) async throws -> RecipeResponse {
        return RecipeResponse.mockRecipe()
    }
}
