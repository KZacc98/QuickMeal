//
//  RecipeView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 23/02/2025.
//

import SwiftUI

struct RecipeView: View {
    let viewModel: RecipeViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.recipe.name)
                .font(.headline)
                .padding()
            
            Text(viewModel.recipe.description)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(
                    horizontal: false,
                    vertical: true)
                .padding()
            
            Text("Steps")
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.recipe.steps, id: \.self) { step in
                        RecipeStepView(step: step)
                            .padding([.trailing, .leading])
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipe: RecipeResponse.mockRecipe()))
}
