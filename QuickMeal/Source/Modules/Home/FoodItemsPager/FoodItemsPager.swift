//
//  FoodItemsPager.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 10/02/2025.
//

import SwiftUI

struct FoodItemsPager: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodCategory.id, ascending: true)],
        animation: .default
    ) var foodCategories: FetchedResults<FoodCategory>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(foodCategories) { category in
                        FoodItemsView(viewModel: FoodItemsViewModel(category: category))
                            .frame(width: geometry.size.width)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)

        }
    }
}

#Preview {
    FoodItemsPager()
}
