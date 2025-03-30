//
//  CDCategoriesRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import CoreData

final class CDCategoriesRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchCategories(
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \FoodCategory.id, ascending: true)]
    ) -> [FoodCategory] {
        let request: NSFetchRequest<FoodCategory> = FoodCategory.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        return (try? context.fetch(request)) ?? []
    }
}
