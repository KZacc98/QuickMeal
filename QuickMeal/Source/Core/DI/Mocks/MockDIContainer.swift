//
//  MockDIContainer.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 31/03/2025.
//

class MockDIContainer: ViewModelFactory {
    private let apiService: GeminiAPIServiceProtocol
    private let persistenceController: PersistenceController
    
    init(
        apiService: GeminiAPIServiceProtocol = MockAPIService(),
        persistenceController: PersistenceController = PersistenceController.preview
    ) {
        self.apiService = apiService
        self.persistenceController = persistenceController
    }
    
    func makeFoodItemsPagerViewModel() -> FoodItemsPagerViewModel {
        let repository = MockCDCategoriesRepository()
        
        return FoodItemsPagerViewModel(apiService: apiService, repository: repository)
    }
    
    func makeFoodItemsViewModel(category: FoodCategory) -> FoodItemsViewModel {
        let repository = MockCDFoodItemsRepository()
        
        return FoodItemsViewModel(category: category, repository: repository)
    }
    
    func makeRecipeViewModel(recipe: RecipeResponse) -> RecipeViewModel {
        let repository = CDRecipeRepository(context: persistenceController.container.viewContext)
        
        return RecipeViewModel(recipe: recipe, repository: repository)
    }
}
