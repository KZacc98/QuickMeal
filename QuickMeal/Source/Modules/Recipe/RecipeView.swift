//
//  RecipeView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 23/02/2025.
//

import SwiftUI
import CoreData

struct RecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var coordinator: Coordinator
    
    @State var isSaved: Bool = false
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
            
            Button("show Saved") {
                coordinator.presentSheet(.test)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            if isSaved {
                viewModel.deleteRecipe(recipe: viewModel.recipe, context: viewContext)
            } else {
                viewModel.saveRecipe(recipe: viewModel.recipe, context: viewContext)
            }
            isSaved.toggle()
        }) {
            Image(systemName: isSaved ? "star.fill" : "star")
        })
        .onAppear {
            checkIfSaved()
        }
    }
    
    private func checkIfSaved() {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name == %@ AND shortInfo == %@ AND %d == steps.@count",
            viewModel.recipe.name,
            viewModel.recipe.description,
            viewModel.recipe.steps.count)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            isSaved = !result.isEmpty
        } catch {
            print("Check failed: \(error)")
        }
    }
}

#Preview {
    RecipeView(viewModel: RecipeViewModel(recipe: RecipeResponse.mockRecipe()))
}
