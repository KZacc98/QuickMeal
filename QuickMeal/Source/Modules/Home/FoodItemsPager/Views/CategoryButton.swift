//
//  CategoryButton.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 16/02/2025.
//

import SwiftUI

/**
 A button representing a single category in the `CategoriesBar`.

 - Parameters:
    - categoryImage: SFSymbol name string.
    - isSelected: A Boolean value indicating whether this category is currently selected.
    - onSelect: A closure to be executed when the category is tapped. This typically updates the selected category in the parent view.

 - Note: The button uses a system image for the category. If the category's image is `nil`, the button will not be displayed.

 - SeeAlso: `CategoriesBar`
 */

struct CategoryButton: View {
    var categoryImage: String?
    var isSelected: Bool
    var onSelect: () -> Void
    
    private let buttonSize: CGFloat = 60
    private let cornerRadius: CGFloat = 12
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isSelected ? Color.blue : Color.clear)
                .frame(width: buttonSize, height: buttonSize)
                .animation(.easeInOut(duration: 0.25), value: isSelected)
            
            if let image = categoryImage {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize * 0.6, height: buttonSize * 0.6)
                    .foregroundColor(isSelected ? .white : .primary)
            }
        }
        .scaleEffect(isSelected ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.25), value: isSelected)
        .onTapGesture {
            withAnimation {
                onSelect()
            }
        }
    }
}

#Preview {
    CategoryButton(categoryImage: "star.fill", isSelected: true, onSelect: {})
    CategoryButton(categoryImage: "star.fill", isSelected: false, onSelect: {})
}
