//
//  SavedRecipesListView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 24/02/2025.
//

import SwiftUI
import CoreData

struct SavedRecipesListView: View {
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.createdAt, ascending: true)]
    ) var recipes: FetchedResults<Recipe>
    
    var body: some View {
        ScrollView {
            VStack{
                if recipes.isEmpty {
                    Text("No saved recipes")
                } else {
                    ForEach(recipes) { recipe in
                        VStack {
                            Text(recipe.name ?? "recipe name")
                            Text(recipe.createdAt?.description ?? "recipe createdAt")
                            Text(recipe.steps?.count.description ?? "recipe step count")
                        }
                        .padding()
                        .background(content: { Color.blue })
                    }
                }
            }
        }
    }
}
