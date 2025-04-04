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
        ScrollView {
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
                
                VStack(alignment: .leading) {
                    ForEach(viewModel.recipe.steps.sorted(by: { $0.stepNumber < $1.stepNumber }), id: \.self) { step in
                        RecipeStepView(step: step)
                            .padding([.trailing, .leading])
                    }
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            if isSaved {
                viewModel.deleteRecipe()
            } else {
                viewModel.saveRecipe()
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
        let fetchRequest: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
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

//#Preview {
//    RecipeView(
//        viewModel: RecipeViewModel(
//            recipe: RecipeResponse.mockRecipe(),
//            repository: .mock()))
//}
