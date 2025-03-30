//
//  DIContainer.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

final class DIContainer: ViewModelFactory {
    private let apiService: GeminiAPIService
    private let persistenceController: PersistenceController
    
    init(
        apiService: GeminiAPIService,
        persistenceController: PersistenceController
    ) {
        self.apiService = apiService
        self.persistenceController = persistenceController
    }
    
    func makeFoodItemsPagerViewModel() -> FoodItemsPagerViewModel {
        let repository = CDCategoriesRepository(context: persistenceController.container.viewContext)
        
        return FoodItemsPagerViewModel(apiService: apiService, repository: repository)
    }
    
    func makeFoodItemsViewModel(category: FoodCategory) -> FoodItemsViewModel {
        let repository = CDFoodItemsRepository(
            context: persistenceController.container.viewContext,
            categoryId: category.id)
        
        return FoodItemsViewModel(category: category, repository: repository)
    }
    
    func makeRecipeViewModel(recipe: RecipeResponse) -> RecipeViewModel {
        let repository = CDRecipeRepository(context: persistenceController.container.viewContext)
        
        return RecipeViewModel(recipe: recipe, repository: repository)
    }
}
