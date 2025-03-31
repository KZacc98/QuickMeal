//
//  CDRecipeRepository.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import CoreData

final class CDRecipeRepository: CDRecipeRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchRecipes(
        sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \CDRecipe.createdAt, ascending: true)]
    ) -> [CDRecipe] {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        return (try? context.fetch(request)) ?? []
    }
    
    func saveRecipe(recipe: RecipeResponse) {
        let fetchRequest: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name == %@ AND shortInfo == %@ AND %d == steps.@count",
            recipe.name,
            recipe.description,
            recipe.steps.count)
        
        do {
            let existing = try context.fetch(fetchRequest)
            guard existing.isEmpty else {
                print("CDRecipe already exists")
                return
            }
            
            let newRecipe = CDRecipe(context: context)
            newRecipe.id = UUID()
            newRecipe.name = recipe.name
            newRecipe.shortInfo = recipe.description
            newRecipe.createdAt = Date()
            
            recipe.steps.forEach { step in
                let newStep = CDRecipeStep(context: context)
                newStep.id = UUID()
                newStep.stepNumber = Int16(step.stepNumber)
                newStep.stepDescription = step.stepDescription
                newStep.recipe = newRecipe
            }
            
            try context.save()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func deleteRecipe(recipe: RecipeResponse) {
        let fetchRequest: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name == %@ AND shortInfo == %@ AND %d == steps.@count",
            recipe.name,
            recipe.description,
            recipe.steps.count)
        
        do {
            let recipes = try context.fetch(fetchRequest)
            recipes.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
