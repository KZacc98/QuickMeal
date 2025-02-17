//
//  FoodItemsView.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/12/2024.
//

import SwiftUI
import CoreData

/**
 A view that displays a grid of `FoodItemView` for a given food category.

 - Parameters:
    - viewModel: A `StateObject` containing the logic for fetching and managing `FoodItem` objects.
    - onItemSelected: A closure triggered when a `FoodItem` is selected.

 - SeeAlso: `FoodItemsViewModel`
 */

struct FoodItemsView: View {
    @StateObject var viewModel: FoodItemsViewModel
    var onItemSelected: ((FoodItem) -> Void)?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            Text(viewModel.category.name ?? "Category Name")
                .font(.title)
                .padding(.top)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.foodItems) { item in
                    FoodItemView(name: item.name, imageName: item.image) {
                        onItemSelected?(item)
                    }
                }
            }
            .padding()
        }
    }
}
