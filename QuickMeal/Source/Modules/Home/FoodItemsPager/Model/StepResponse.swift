//
//  StepResponse.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//

import Foundation

/**
Represents a single step in a recipe

- Note: Used in both API communication and UI presentation
*/
struct StepResponse: Codable, Hashable {
    let stepNumber: Int
    let stepDescription: String
}

extension StepResponse {
    static func mock() -> StepResponse {
        return StepResponse(stepNumber: 1, stepDescription: "Preheat oven to 400°F (200°C).")
    }
}
