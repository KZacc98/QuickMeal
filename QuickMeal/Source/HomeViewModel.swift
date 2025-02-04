//
//  HomeViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var foodItems: [FoodItem] {
        didSet {
            print("FoodItems: \n")
            foodItems.forEach { item in
                dump(item.name)
            }
        }
    }
    
    init(foodItems: [FoodItem] = []) {
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
