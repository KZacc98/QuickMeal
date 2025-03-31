//
//  MockCDFoodItemsRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 31/03/2025.
//

import CoreData

class MockCDFoodItemsRepository: CDFoodItemsRepositoryProtocol {
    private let context = PersistenceController.preview
    
    func fetchFoodItems(
        for categoryId: String?,
        sortDescriptors: [NSSortDescriptor]
    ) -> [FoodItem] {
        let request: NSFetchRequest<CDFoodItem> = CDFoodItem.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        if let categoryId {
            request.predicate = NSPredicate(format: "categoryId == %@", categoryId)
        }
        
        let coreDataItems = (try? context.container.viewContext.fetch(request)) ?? []
        
        return coreDataItems.compactMap {
            FoodItem(id: $0.id, name: $0.name, categoryId: $0.categoryId, image: $0.image)
        }
    }
}
