//
//  FoodItemsViewModel.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 04/02/2025.
//

import SwiftUI
import CoreData

/**
 A ViewModel responsible for managing and fetching `FoodItem` instances based on the selected `FoodCategory`.

 - Parameters:
    - category: The currently selected `FoodCategory`. Updating this category triggers a new fetch.
    - context: The `NSManagedObjectContext` used to fetch data from Core Data.

 - Properties:
    - `foodItems`: A `@Published` array of `FoodItem` objects.
    - `categoryId`: The ID of the currently selected category, used for filtering.

 - SeeAlso: `FoodItemsView`
 */

class FoodItemsViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var category: FoodCategory
    @Published var foodItems: [FoodItem] = []
    
    var categoryId: String? {
        category.id
    }
    
    // MARK: - Private Properties
    
    private let repository: CDFoodItemsRepository
    
    // MARK: - Initialization
    
    init(category: FoodCategory, repository: CDFoodItemsRepository) {
        self.category = category
        self.repository = repository
        self.foodItems = repository.fetchFoodItems(for: category.id)
    }
}
