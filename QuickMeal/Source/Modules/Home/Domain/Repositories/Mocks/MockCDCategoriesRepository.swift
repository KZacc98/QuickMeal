//
//  MockCDCategoriesRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 31/03/2025.
//

import CoreData

class MockCDCategoriesRepository: CDCategoriesRepositoryProtocol {
    private let context = PersistenceController.preview
    
    func fetchCategories(
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \CDFoodCategory.id, ascending: true)]
    ) -> [FoodCategory] {
        let request: NSFetchRequest<CDFoodCategory> = CDFoodCategory.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        let coreDataItems = (try? context.container.viewContext.fetch(request)) ?? []
        
        return coreDataItems.compactMap {
            FoodCategory(id: $0.id, name: $0.name, image: $0.image)
        }
    }
}
