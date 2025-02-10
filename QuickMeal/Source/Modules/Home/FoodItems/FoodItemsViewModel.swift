//
//  FoodItemsViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI
import CoreData

class FoodItemsViewModel: ObservableObject {
    @Published var hideButton: Bool = true
    @Published var category: FoodCategory
    @Published var foodItems: [FoodItem] {
        didSet {
            withAnimation(.easeInOut(duration: 0.25)) {
                hideButton = foodItems.isEmpty
            }
            
            print("FoodItems: \n")
            foodItems.forEach { item in
                dump(item.name)
            }
        }
    }
    
    var categoryId: String? {
        category.id
    }
    
    init(category: FoodCategory, foodItems: [FoodItem] = []) {
        self.category = category
        self.foodItems = foodItems
    }
    
    func manageFoodItems(_ foodItem: FoodItem) {
        if foodItems.contains(foodItem) {
            foodItems.removeAll { $0 == foodItem }
        } else {
            foodItems.append(foodItem)
        }
    }
}
