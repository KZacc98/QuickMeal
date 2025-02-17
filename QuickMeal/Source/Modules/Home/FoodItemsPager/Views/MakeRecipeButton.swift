//
//  MakeRecipeButton.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 06/02/2025.
//

import SwiftUI

struct MakeRecipeButton: View {
    let requiredCount: Int
    let currentCount: Int
    var action: () -> Void
    
    private var progress: CGFloat {
        let max = max(requiredCount, 1)
        
        return CGFloat(currentCount) / CGFloat(max)
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            GeometryReader { geometry in
                ZStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.gray.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.blue)
                            .frame(width: min(progress * geometry.size.width, geometry.size.width))
                            .animation(.easeOut, value: currentCount)
                    }
                    
                    Text("Make Recipe")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 25))
        }
        .disabled(progress < 1)
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    VStack {
        Spacer()
        
        MakeRecipeButton(requiredCount: 10, currentCount: 5) {
            print("")
        }
    }
}
