//
//  FoodItemsPagerView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 17/02/2025.
//

import SwiftUI
import CoreData

struct FoodItemsPagerView: View {
    @Binding var selectedCategoryId: String?
    
    let geometry: GeometryProxy
    let foodCategories: FetchedResults<FoodCategory>
    let onItemSelected: (FoodItem) -> Void
    
    private let context: NSManagedObjectContext
    
    init(geometry: GeometryProxy,
         foodCategories: FetchedResults<FoodCategory>,
         selectedCategoryId: Binding<String?>,
         context: NSManagedObjectContext,
         onItemSelected: @escaping (FoodItem) -> Void) {
        self.geometry = geometry
        self.foodCategories = foodCategories
        self._selectedCategoryId = selectedCategoryId
        self.context = context
        self.onItemSelected = onItemSelected
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(foodCategories) { category in
                    FoodItemsView(
                        viewModel: FoodItemsViewModel(
                            category: category,
                            context: context
                        ),
                        onItemSelected: onItemSelected
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
    
    private func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
