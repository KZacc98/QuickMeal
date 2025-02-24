//
//  RecipeViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 24/02/2025.
//

import Foundation

class RecipeViewModel: ObservableObject {
    let recipe: RecipeResponse
    
    let id = UUID()
    
    init(recipe: RecipeResponse) {
        self.recipe = recipe
    }
}
