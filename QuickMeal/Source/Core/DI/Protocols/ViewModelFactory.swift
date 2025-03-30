//
//  ViewModelFactory.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

protocol ViewModelFactory {
    func makeFoodItemsPagerViewModel() -> FoodItemsPagerViewModel
    func makeFoodItemsViewModel(category: FoodCategory) -> FoodItemsViewModel
    func makeRecipeViewModel(recipe: RecipeResponse) -> RecipeViewModel
}
