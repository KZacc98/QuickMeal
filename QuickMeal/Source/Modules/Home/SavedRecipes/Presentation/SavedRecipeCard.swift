//
//  SavedRecipeCard.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/03/2025.
//

import SwiftUI

struct SavedRecipeCard: View {
    let recipe: CDRecipe
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.blue)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(recipe.name ?? "Recipe name")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                        
                        Text(recipe.shortInfo ?? "Recipe description")
                            .foregroundStyle(Color.white)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 10)
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
