//
//  CDCategoriesRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import CoreData

final class CDCategoriesRepository: CDCategoriesRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchCategories(
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \CDFoodCategory.id, ascending: true)]
    ) -> [FoodCategory] {
        let request: NSFetchRequest<CDFoodCategory> = CDFoodCategory.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        let coreDataItems = (try? context.fetch(request)) ?? []
        
        return coreDataItems.compactMap {
            FoodCategory(id: $0.id, name: $0.name, image: $0.image)
        }
    }
}
