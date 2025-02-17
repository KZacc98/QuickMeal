//
//  FoodItemsPager.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 10/02/2025.
//

import SwiftUI

struct FoodItemsPager: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: FoodItemsPagerViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedCategoryId: String? = nil
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FoodCategory.id, ascending: true)],
        animation: .default
    ) var foodCategories: FetchedResults<FoodCategory>
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CategoriesBar(
                    geometry: geometry,
                    foodCategories: foodCategories,
                    selectedCategoryId: $selectedCategoryId
                )
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(foodCategories) { category in
                            FoodItemsView(
                                viewModel: FoodItemsViewModel(
                                    category: category,
                                    context: viewContext),
                                onItemSelected: { item in
                                    triggerHapticFeedback(style: .medium)
                                    viewModel.manageFoodItems(item)
                                }
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
                .overlay {
                    if viewModel.hideButton == false {
                        VStack {
                            Spacer()
                            MakeRecipeButton(
                                requiredCount: 3,
                                currentCount: viewModel.foodItems.count
                            ) {
                                coordinator.presentSheet(.test)
                            }
                            .frame(height: geometry.size.height * 0.08)
                            .padding()
                        }
                    }
                }
            }
        }
        .onChange(of: selectedCategoryId) { _, newValue in
            triggerHapticFeedback()
        }
        .onAppear {
            if let firstCategoryId = foodCategories.first?.id {
                selectedCategoryId = firstCategoryId
            }
        }
    }
    
    private func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
