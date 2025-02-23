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
            Text(viewModel.recipe.description)
            Text("Steps")
            ForEach(viewModel.recipe.steps, id: \.self) { step in
                Text(step.stepDescription)
            }
        }
    }
}

class RecipeViewModel: ObservableObject {
    let recipe: RecipeResponse
    
    let id = UUID()
    
    init(recipe: RecipeResponse) {
        self.recipe = recipe
    }
}
//
//#Preview {
//    RecipeView()
//}
