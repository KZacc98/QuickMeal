//
//  RecipeStepView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 24/02/2025.
//

import SwiftUI

struct RecipeStepView: View {
    var step: StepResponse
    
    var body: some View {
        HStack {
            ZStack{
                Circle()
                    .foregroundStyle(Color.blue)
                    .frame(width: 32, height: 32)
                    .overlay {
                        Text(step.stepNumber.description)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
            }
            
            Text(step.stepDescription)
                .font(.caption)
                .foregroundColor(.primary)
            
        }
    }
}

#Preview {
    RecipeStepView(step: StepResponse.mock())
}
