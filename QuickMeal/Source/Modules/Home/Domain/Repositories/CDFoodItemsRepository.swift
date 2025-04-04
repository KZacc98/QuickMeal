//
//  CDFoodItemsRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import CoreData

final class CDFoodItemsRepository: CDFoodItemsRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, categoryId: String?) {
        self.context = context
    }
    
    func fetchFoodItems(
        for categoryId: String?,
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \CDFoodItem.name, ascending: true)]
    ) -> [FoodItem] {
        let request: NSFetchRequest<CDFoodItem> = CDFoodItem.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        if let categoryId {
            request.predicate = NSPredicate(format: "categoryId == %@", categoryId)
        }
        
        let coreDataItems = (try? context.fetch(request)) ?? []
        
        return coreDataItems.compactMap {
            FoodItem(id: $0.id, name: $0.name, categoryId: $0.categoryId, image: $0.image)
        }
    }
}
