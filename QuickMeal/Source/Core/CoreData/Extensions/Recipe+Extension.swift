//
//  Recipe+Extension.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/03/2025.
//

extension Recipe {
    func toRecipeResponse() -> RecipeResponse {
        let steps = (self.steps?.allObjects as? [RecipeStep]) ?? []
        let stepResponses = steps.map { $0.toStepResponse() }
        
        return RecipeResponse(
            name: self.name ?? "",
            description: self.shortInfo ?? "",
            steps: stepResponses
        )
    }
}
