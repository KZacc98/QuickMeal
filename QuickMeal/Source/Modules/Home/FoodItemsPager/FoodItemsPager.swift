//
//  FoodItemsPager.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 10/02/2025.
//

import SwiftUI
import CoreData

struct FoodItemsPager: View, Haptic {
    @StateObject var viewModel: FoodItemsPagerViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedCategoryId: String? = nil
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CategoriesBar(
                    geometry: geometry,
                    foodCategories: viewModel.categories,
                    selectedCategoryId: $selectedCategoryId
                )
                
                FoodItemsPagerView(
                    geometry: geometry,
                    foodCategories: viewModel.categories,
                    selectedCategoryId: $selectedCategoryId,
                    onItemSelected: { item in
                        triggerHapticFeedback(style: .medium)
                        viewModel.manageFoodItems(item)
                    },
                    isItemSelected: { foodItem in
                        return viewModel.foodItems.contains(foodItem)
                    }
                )
                .overlay {
                    if viewModel.hideButton == false {
                        VStack {
                            Spacer()
                            
                            MakeRecipeButton(
                                requiredCount: 3,
                                currentCount: viewModel.foodItems.count,
                                action: { makeRecipe() })
                            .frame(height: geometry.size.height * 0.08)
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            if let firstCategoryId = viewModel.categories.first?.id {
                selectedCategoryId = firstCategoryId
            }
        }
    }
    
    private func makeRecipe() {
        viewModel.makeRecipe { result in
            switch result {
            case .success(let success):
                guard let response = success else { return }
                
                Task { @MainActor in
                    coordinator.push(.recipe(recipe: response))
                }
            case .failure(let failure):
                coordinator.push(.recipe(recipe: .mockRecipe()))
            }
        }
    }
}

#Preview {
    Group {
        FoodItemsPager(viewModel: FoodItemsPagerViewModel(apiService: MockAPIService(), repository: MockCDCategoriesRepository()))
    }
    .environmentObject(Coordinator(factory: MockDIContainer()))
    
}

