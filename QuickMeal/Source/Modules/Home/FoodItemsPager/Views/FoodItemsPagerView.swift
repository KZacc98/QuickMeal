//
//  FoodItemsPagerView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 17/02/2025.
//

import SwiftUI
import CoreData

struct FoodItemsPagerView: View, Haptic {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var selectedCategoryId: String?
    
    let geometry: GeometryProxy
    let foodCategories: [FoodCategory]
    let onItemSelected: (FoodItem) -> Void
    let isItemSelected: (FoodItem) -> Bool
    
    init(geometry: GeometryProxy,
         foodCategories: [FoodCategory],
         selectedCategoryId: Binding<String?>,
         onItemSelected: @escaping (FoodItem) -> Void,
         isItemSelected: @escaping (FoodItem) -> Bool) {
        self.geometry = geometry
        self.foodCategories = foodCategories
        self._selectedCategoryId = selectedCategoryId
        self.onItemSelected = onItemSelected
        self.isItemSelected = isItemSelected
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
//                SavedRecipesListView()
//                    .frame(width: geometry.size.width)
//                    .id("0")
                
                ForEach(foodCategories) { category in
                    FoodItemsView(
                        viewModel: coordinator.makeFoodItemsViewModel(for: category),
                        onItemSelected: onItemSelected,
                        isSelected: isItemSelected
                    )
                    .frame(width: geometry.size.width)
                    .id(category.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $selectedCategoryId)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        .onChange(of: selectedCategoryId) { _, newValue in
            triggerHapticFeedback()
        }
    }
}
