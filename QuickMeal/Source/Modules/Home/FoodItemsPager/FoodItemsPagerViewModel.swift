//
//  FoodItemsPagerViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 11/02/2025.
//

import SwiftUI

class FoodItemsPagerViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var hideButton: Bool = true
    @Published var categories: [FoodCategory] = []
    @Published var foodItems: [FoodItem] = [] {
        didSet {
            withAnimation(.easeInOut(duration: 0.25)) {
                hideButton = foodItems.isEmpty
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let apiService: GeminiAPIService
    private let repository: CDCategoriesRepository
    
    // MARK: - Initialization
    
    init(apiService: GeminiAPIService, repository: CDCategoriesRepository) {
        self.apiService = apiService
        self.repository = repository
        self.categories = repository.fetchCategories()
    }
    
    // MARK: - Public Methods
    
    func manageFoodItems(_ foodItem: FoodItem) {
        if foodItems.contains(foodItem) {
            foodItems.removeAll { $0 == foodItem }
        } else {
            foodItems.append(foodItem)
        }
    }
    
    func makeRecipe(completion: @escaping (Result<RecipeResponse?, Error>) -> Void) {
        Task {
            do {
                let response = try await apiService.fetchGeminiResponse(prompt: makePrompt(foodItems: foodItems))
                
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func makePrompt(foodItems: [FoodItem]) -> String {
        let foodItemsList = foodItems.map { $0.name ?? "" }.joined(separator: ",")
        
        return """
\(foodItemsList)
"""
    }
}


