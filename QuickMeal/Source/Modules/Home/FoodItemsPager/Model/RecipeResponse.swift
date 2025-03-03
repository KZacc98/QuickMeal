//
//  RecipeResponse.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 13/02/2025.
//
import Foundation

/**
Main recipe model containing all recipe information

- Important: This is the primary domain model for recipe data
- Note: Used in both API communication and UI presentation
*/
struct RecipeResponse: Codable {
    let name: String
    let description: String
    let steps: [StepResponse]
}

extension RecipeResponse {
    var uniqueKey: String {
        "\(name)-\(description)-\(steps.count)"
    }
    
    static func mockRecipe() -> RecipeResponse {
        return RecipeResponse(
            name: "Garlic Butter Chicken with Roasted Broccoli and Carrot Rice",
            description: "Simple one-pan meal with chicken, broccoli, carrots, and cheesy rice.",
            steps: [
                StepResponse(stepNumber: 1, stepDescription: "Preheat oven to 400°F (200°C)."),
                StepResponse(stepNumber: 2, stepDescription: "Chop broccoli and carrots into bite-sized pieces. Mince garlic."),
                StepResponse(stepNumber: 3, stepDescription: "In a large bowl, toss broccoli and carrots with olive oil, salt, and black pepper."),
                StepResponse(stepNumber: 4, stepDescription: "Spread broccoli and carrots in a single layer on a baking sheet."),
                StepResponse(stepNumber: 5, stepDescription: "Roast for 20-25 minutes, or until tender-crisp."),
                StepResponse(stepNumber: 6, stepDescription: "While vegetables roast, cook rice according to package directions."),
                StepResponse(stepNumber: 7, stepDescription: "In a separate pan, melt butter over medium heat. Add minced garlic and cook for 1 minute, until fragrant."),
                StepResponse(stepNumber: 8, stepDescription: "Add chicken to the pan and cook until browned on all sides."),
                StepResponse(stepNumber: 9, stepDescription: "Season chicken with salt and black pepper."),
                StepResponse(stepNumber: 10, stepDescription: "Once chicken is cooked through, stir in cooked rice."),
                StepResponse(stepNumber: 11, stepDescription: "Stir in shredded cheddar cheese until melted and combined."),
                StepResponse(stepNumber: 12, stepDescription: "Serve chicken and rice mixture alongside the roasted broccoli and carrots.")
            ]
        )
    }
}
