//
//  PersistenceController.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 28/01/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
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
        
        // Load data once
        if isFirstLaunch() {
            loadJSONData()
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error saving")
            }
        }
    }
    
    /// Deletes all existing `FoodItem` entries from Core Data
    func clearData() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FoodItem.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("⚠️ All food items deleted!")
        } catch {
            print("❌ Error deleting Core Data: \(error.localizedDescription)")
        }
    }
    
    /// Checks if it's the first launch by storing a flag in UserDefaults
    private func isFirstLaunch() -> Bool {
        let key = "hasLoadedJSONData"
        if UserDefaults.standard.bool(forKey: key) {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: key)
            return true
        }
    }
    
    /// Loads data from FoodItems.json and saves it to Core Data
    func loadJSONData(forceReload: Bool = false) {
        let key = "hasLoadedJSONData"

        if !forceReload && UserDefaults.standard.bool(forKey: key) {
            print("⚠️ JSON already loaded, skipping.")
            return
        }

        guard let url = Bundle.main.url(forResource: "FoodItems", withExtension: "json") else {
            print("❌ JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedItems = try JSONDecoder().decode([FoodItemData].self, from: data)
            let context = container.viewContext

            // First, clear existing data
            clearData()

            // Insert new items
            for item in decodedItems {
                let newItem = FoodItem(context: context)
                newItem.id = UUID()
                newItem.name = item.name
                newItem.image = item.image
            }

            try context.save()
            UserDefaults.standard.set(true, forKey: key) // Mark as loaded
            print("✅ JSON data reloaded successfully!")

        } catch {
            print("❌ Error loading JSON: \(error.localizedDescription)")
        }
    }
}
