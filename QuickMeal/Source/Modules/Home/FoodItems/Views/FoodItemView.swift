//
//  FoodItemView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI

struct FoodItemView: View {
    @State var isSelected: Bool
    
    var name: String?
    var imageName: String?
    var onTapAction: (() -> Void)?
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.blue.opacity(0.5) : Color.gray.opacity(0.1))
            
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
                        .allowsTightening(true)
                }
            }
            .padding(20)
        }
        .onTapGesture {
            onTapAction?()
            withAnimation(.easeIn(duration: 0.15)) {
                isSelected.toggle()
            }
            print("\(name ?? "unknown") \(isSelected)")
        }
        .scaleEffect(isSelected ? 0.95 : 1.0)
    }
}

#Preview {
    GeometryReader { geometry in
        HStack(spacing: 0) {
            FoodItemView(isSelected: true, name: "Cauliflower", imageName: "fish.fill")
                .frame(width: geometry.size.width * 0.50)
            FoodItemView(isSelected: true, name: "red bell pepper", imageName: "microbe.fill")
                .frame(width: geometry.size.width * 0.50)
        }
    }
}
