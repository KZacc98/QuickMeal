//
//  CDFoodItemsRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import CoreData

final class CDFoodItemsRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, categoryId: String?) {
        self.context = context
    }
    
    func fetchFoodItems(
        for categoryId: String?,
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \FoodItem.name, ascending: true)]
    ) -> [FoodItem] {
        let request: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        if let categoryId {
            request.predicate = NSPredicate(format: "categoryId == %@", categoryId)
        }
        
        return (try? context.fetch(request)) ?? []
    }
}
