//
//  PersistenceController.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 28/01/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let context = result.container.viewContext
        
        for i in 0..<50 {
            let newItem = CDFoodItem(context: context)
            newItem.id = UUID()
            newItem.name = "\(i.description) item "
            newItem.image = "document.fill"
            newItem.categoryId = Int.random(in: 1...5).description
        }
        
        for i in 1...5 {
            let newCategory = CDFoodCategory(context: context)
            newCategory.id = i.description
            newCategory.name = "category name \(i.description)"
            newCategory.image = "document.fill"
        }

        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "QuickMeal")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        // Load data once on first launch
        if isFirstLaunch() {
            loadJSONData(forceReload: true)
        }
    }
}

// MARK: - Helper Functions

extension PersistenceController {
    // MARK: - Core Data Operations
    
    /// Saves changes in the view context if there are any.
    func save() {
        let context = container.viewContext

        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            print("❌ Error saving Core Data: \(error.localizedDescription)")
        }
    }
    
    /// Deletes all existing `FoodItem` and `FoodCategory` entries from Core Data.
    func clearData() {
        let context = container.viewContext

        // Delete all FoodItem entities
        let foodItemFetchRequest: NSFetchRequest<NSFetchRequestResult> = CDFoodItem.fetchRequest()
        let foodItemDeleteRequest = NSBatchDeleteRequest(fetchRequest: foodItemFetchRequest)

        // Delete all FoodCategory entities
        let foodCategoryFetchRequest: NSFetchRequest<NSFetchRequestResult> = CDFoodCategory.fetchRequest()
        let foodCategoryDeleteRequest = NSBatchDeleteRequest(fetchRequest: foodCategoryFetchRequest)
        
        // Delete all saved recipe steps
        let recipeStepsFetchRequest: NSFetchRequest<NSFetchRequestResult> = CDRecipeStep.fetchRequest()
        let recipeStepsDeleteRequest = NSBatchDeleteRequest(fetchRequest: recipeStepsFetchRequest)
        
        // Delete all saved recipes
        let recipesFetchRequest: NSFetchRequest<NSFetchRequestResult> = CDRecipe.fetchRequest()
        let recipesDeleteRequest = NSBatchDeleteRequest(fetchRequest: recipesFetchRequest)
        
        
        do {
            // Execute delete requests
            try context.execute(foodItemDeleteRequest)
            try context.execute(foodCategoryDeleteRequest)
            try context.execute(recipeStepsDeleteRequest)
            try context.execute(recipesDeleteRequest)

            // Save the context to persist changes
            try context.save()
            print("⚠️ All food items and categories deleted!")
        } catch {
            print("❌ Error deleting Core Data: \(error.localizedDescription)")
        }
    }
    
    /// Checks if it's the first launch by storing a flag in UserDefaults.
    private func isFirstLaunch() -> Bool {
        let key = "hasLoadedJSONData"
        if UserDefaults.standard.bool(forKey: key) {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: key)
            return true
        }
    }
    
    // MARK: - JSON Loading
    
    /// Loads data from JSON files and saves it to Core Data.
    func loadJSONData(forceReload: Bool = false) {
        let hasLoadedKey = "hasLoadedJSONData"

        guard forceReload || !UserDefaults.standard.bool(forKey: hasLoadedKey) else {
            print("⚠️ JSON already loaded, skipping.")
            return
        }

        guard let foodItemsURL = Bundle.main.url(forResource: "FoodItems", withExtension: "json"),
              let foodCategoriesURL = Bundle.main.url(forResource: "FoodCategories", withExtension: "json") else {
            print("❌ JSON file not found")
            return
        }

        do {
            let foodItems = try decodeJSON(from: foodItemsURL, as: [FoodItemData].self)
            let foodCategories = try decodeJSON(from: foodCategoriesURL, as: [FoodCategoryData].self)
            let context = container.viewContext

            // Clear existing data
            clearData()

            // Insert new items
            insertFoodItems(foodItems, into: context)
            insertFoodCategories(foodCategories, into: context)

            try context.save()
            UserDefaults.standard.set(true, forKey: hasLoadedKey) // Mark as loaded
            print("✅ JSON data reloaded successfully!")

        } catch {
            print("❌ Error loading JSON: \(error.localizedDescription)")
        }
    }
    
    /// Decodes JSON data from a URL into a specified type.
    private func decodeJSON<T: Decodable>(from url: URL, as type: T.Type) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    /// Inserts an array of `FoodItemData` into Core Data.
    private func insertFoodItems(_ items: [FoodItemData], into context: NSManagedObjectContext) {
        for item in items {
            let newItem = CDFoodItem(context: context)
            newItem.id = UUID()
            newItem.name = item.name
            newItem.image = item.image
            newItem.categoryId = item.categoryId
        }
    }
    
    /// Inserts an array of `FoodCategoryData` into Core Data.
    private func insertFoodCategories(_ categories: [FoodCategoryData], into context: NSManagedObjectContext) {
        for category in categories {
            let newCategory = CDFoodCategory(context: context)
            newCategory.id = category.id
            newCategory.name = category.name
            newCategory.image = category.image
        }
    }
}
