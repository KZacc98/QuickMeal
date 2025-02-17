
struct FoodItemsPagerView: View {
    let geometry: GeometryProxy
    let foodCategories: FetchedResults<FoodCategory>
    @Binding var selectedCategoryId: String?
    let onItemSelected: (FoodItem) -> Void
    
    private let context: NSManagedObjectContext
    
    init(geometry: GeometryProxy,
         foodCategories: FetchedResults<FoodCategory>,
         selectedCategoryId: Binding<String?>,
         onItemSelected: @escaping (FoodItem) -> Void,
         context: NSManagedObjectContext) {
        self.geometry = geometry
        self.foodCategories = foodCategories
        self._selectedCategoryId = selectedCategoryId
        self.onItemSelected = onItemSelected
        self.context = context
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(foodCategories) { category in
                    FoodItemsView(
                        viewModel: FoodItemsViewModel(
                            category: category,
                            context: context
                        ),
                        onItemSelected: onItemSelected
                    )
                    .frame(width: geometry.size.width)
                    .id(category.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $selectedCategoryId)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        .onChange(of: selectedCategoryId) { _, newValue in
            triggerHapticFeedback()
        }
    }
    
    private func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
