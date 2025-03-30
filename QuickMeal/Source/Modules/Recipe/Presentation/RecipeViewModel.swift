//
//  RecipeViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 24/02/2025.
//

import Foundation
import CoreData

class RecipeViewModel: ObservableObject {
    let recipe: RecipeResponse
    let repository: CDRecipeRepository
    
    let id = UUID()
    
    init(recipe: RecipeResponse, repository: CDRecipeRepository) {
        self.recipe = recipe
        self.repository = repository
    }
    
    func deleteRecipe() {
        repository.deleteRecipe(recipe: recipe)
    }
    
    func saveRecipe() {
        repository.saveRecipe(recipe: recipe)
    }
}
