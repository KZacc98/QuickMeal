//
//  FoodItemsPager.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 10/02/2025.
//

import SwiftUI

struct FoodItemsPager: View {
    @StateObject var viewModel: FoodItemsPagerViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodCategory.id, ascending: true)],
        animation: .default
    ) var foodCategories: FetchedResults<FoodCategory>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(foodCategories) { category in
                        FoodItemsView(viewModel: FoodItemsViewModel(category: category), onItemSelected: { item in
                            viewModel.manageFoodItems(item)
                        })
                        .frame(width: geometry.size.width)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)
            .overlay {
                if viewModel.hideButton == false {
                    VStack {
                        Spacer()
                        MakeRecipeButton(requiredCount: 3, currentCount: viewModel.foodItems.count) {
//                            print("make recipe with:")
//                            viewModel.foodItems.forEach { item in
//                                guard let name = item.name else { return }
//                                print(name)
//                            }
                            viewModel.makeRecipe()
                        }
                        .frame(height: geometry.size.height * 0.08)
                        .padding()
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    FoodItemsPager()
//}
