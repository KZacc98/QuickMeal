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
    @Published var category: FoodCategory
    @Published var foodItems: [FoodItem] = []  // Stores fetched items
    
    private let context: NSManagedObjectContext
    
    var categoryId: String? {
        category.id
    }
    
    init(category: FoodCategory, context: NSManagedObjectContext) {
        self.category = category
        self.context = context
        fetchFoodItems()
    }
    
    ///Fetches food items from Core Data filtered by `categoryId`.
    func fetchFoodItems() {
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)]
        
        if let categoryId = categoryId {
            fetchRequest.predicate = NSPredicate(format: "categoryId == %@", categoryId)
        }
        
        do {
            foodItems = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching food items: \(error)")
        }
    }
}
