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
    - category: The `FoodCategory` model representing the category to be displayed.
    - isSelected: A Boolean value indicating whether this category is currently selected.
    - onSelect: A closure to be executed when the category is tapped. This typically updates the selected category in the parent view.

 - Note: The button uses a system image for the category. If the category's image is `nil`, the button will not be displayed.

 - SeeAlso: `CategoriesBar`
 */

struct CategoryButton: View {
    var category: FoodCategory
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        if let image = category.image {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background {
                    if isSelected {
                        Color.red
                    }
                }
                .onTapGesture {
                    onSelect()
                }
        }
    }
}
