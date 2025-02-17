//
//  CategoriesBar.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 16/02/2025.
//

import SwiftUI

/**
 A horizontal scrollable bar that displays available categories.

 - Parameters:
    - geometry: A `GeometryProxy` passed from the parent view to correctly size the view.
    - foodCategories: A collection of `FoodCategory` items to be displayed in the bar.
    - selectedCategoryId: A `Binding` to the currently selected category's ID. This is used to highlight the selected category and synchronize with a connected view.

 - SeeAlso: `FoodItemsPager`
 */

import SwiftUI

struct CategoriesBar: View {
    var geometry: GeometryProxy
    var foodCategories: FetchedResults<FoodCategory>
    @Binding var selectedCategoryId: String?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(foodCategories) { category in
                    CategoryButton(
                        category: category,
                        isSelected: selectedCategoryId == category.id,
                        onSelect: {
                            selectedCategoryId = category.id
                        }
                    )
                }
            }
            .frame(height: geometry.size.height * 0.1)
            .padding(.horizontal)
        }
    }
}
