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
        entity: CDRecipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDRecipe.createdAt, ascending: true)]
    ) var recipes: FetchedResults<CDRecipe>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10){
                if recipes.isEmpty {
                    Text("No saved recipes")
                } else {
                    ForEach(recipes) { recipe in
                        SavedRecipeCard(recipe: recipe) {
                            coordinator.push(.recipe(recipe: recipe.toRecipeResponse()))
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
