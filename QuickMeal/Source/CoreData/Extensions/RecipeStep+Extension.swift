//
//  RecipeStep+Extension.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/03/2025.
//

extension RecipeStep {
    func toStepResponse() -> StepResponse {
        StepResponse(
            stepNumber: Int(self.stepNumber),
            stepDescription: self.stepDescription ?? ""
        )
    }
}
