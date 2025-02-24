//
//  StepResponse.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//

import Foundation

struct StepResponse: Codable, Hashable {
    let stepNumber: Int
    let stepDescription: String
}

extension StepResponse {
    static func mock() -> StepResponse {
        return StepResponse(stepNumber: 1, stepDescription: "Preheat oven to 400°F (200°C).")
    }
}
