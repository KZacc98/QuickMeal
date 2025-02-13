//
//  RecipeResponse.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//
import Foundation

struct RecipeResponse: Codable {
    let name: String
    let description: String
    let steps: [StepResponse]
}
