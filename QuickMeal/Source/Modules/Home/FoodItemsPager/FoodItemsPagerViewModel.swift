//
//  FoodItemsPagerViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 11/02/2025.
//

import SwiftUI

class FoodItemsPagerViewModel: ObservableObject {
    @Published var hideButton: Bool = true
    @Published var foodItems: [FoodItem] = [] {
        didSet {
            withAnimation(.easeInOut(duration: 0.25)) {
                hideButton = foodItems.isEmpty
            }
        }
    }
    
    let apiService: APIService = APIService(apiKey: "")
    
    func manageFoodItems(_ foodItem: FoodItem) {
        if foodItems.contains(foodItem) {
            foodItems.removeAll { $0 == foodItem }
        } else {
            foodItems.append(foodItem)
        }
    }
    
    func makeRecipe() {
        Task {
            do {
                let response = try await apiService.fetchGeminiResponse(prompt: makePrompt(foodItems: foodItems))
                print("Gemini Response: \(response)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func makePrompt(foodItems: [FoodItem]) -> String {
        let foodItemsList = foodItems.map { $0.name ?? "" }.joined(separator: ",")
        
        return """

"""
    }
}
