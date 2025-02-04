//
//  FoodItemView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI

struct FoodItemView: View {
    @State var isSelected: Bool = false
    
    var name: String?
    var imageName: String?
    var onTapAction: (() -> Void)?
    
    var body: some View {
        VStack {
            if let imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            if let name {
                Text(name)
                    .font(.body)
                    .lineLimit(2)
            }
        }
        .padding(20)
        .background {
            if isSelected {
                Color.blue.opacity(0.5)
            } else {
                Color.gray.opacity(0.1)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            onTapAction?()
            withAnimation(.easeIn(duration: 0.15)) {
                isSelected.toggle()
            }
            print("\(name ?? "unknown") \(isSelected)")
        }
    }
}

#Preview {
    GeometryReader { geometry in
        HStack(spacing: 0) {
            FoodItemView(name: "Cauliflower", imageName: "fish.fill")
                .frame(width: geometry.size.width * 0.50)
            FoodItemView(name: "red bell pepper", imageName: "microbe.fill")
                .frame(width: geometry.size.width * 0.50)
        }
    }
}
