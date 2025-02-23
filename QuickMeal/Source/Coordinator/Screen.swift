//
//  Screen.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

enum Screen: Hashable, Equatable {
    case home
    case recipe(recipeViewModel: RecipeViewModel)
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.recipe(let lhsRecipeVM), .recipe(let rhsRecipeVM)):
            return lhsRecipeVM.id == rhsRecipeVM.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .recipe:
            hasher.combine("recipe")
        }
    }
}
