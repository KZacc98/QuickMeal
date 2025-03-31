//
//  CDRecipeRepositoryProtocol.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import Foundation

protocol CDRecipeRepositoryProtocol {
    func fetchRecipes(sortDescriptors: [NSSortDescriptor]) -> [CDRecipe]
    func saveRecipe(recipe: RecipeResponse)
    func deleteRecipe(recipe: RecipeResponse)
}
