//
//  FoodItemsViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI
import CoreData

class FoodItemsViewModel: ObservableObject {
    @Published var category: FoodCategory
    
    var categoryId: String? {
        category.id
    }
    
    init(category: FoodCategory) {
        self.category = category
    }
}
