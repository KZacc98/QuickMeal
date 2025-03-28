//
//  SavedRecipesListView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 24/02/2025.
//

import SwiftUI
import CoreData

struct SavedRecipesListView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.createdAt, ascending: true)]
    ) var recipes: FetchedResults<Recipe>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10){
                if recipes.isEmpty {
                    Text("No saved recipes")
                } else {
                    ForEach(recipes) { recipe in
                        SavedRecipeCard(recipe: recipe) {
                            let viewModel = RecipeViewModel(recipe: RecipeResponse(recipe: recipe))
                            
                            coordinator.push(.recipe(recipeViewModel: viewModel))
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
